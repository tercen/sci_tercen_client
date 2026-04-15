/// Test script for the WorkflowViewer's getWorkflowGraph transform.
///
/// Usage:
///   TERCEN_URI=https://stage.tercen.com TERCEN_TOKEN=... dart run 18_workflow_graph.dart [workflowId]
///
/// If no workflowId is given, finds the first workflow in the first project.
/// Prints the transformed {name, nodes, edges} payload that DirectedGraph expects.

import 'dart:convert';
import 'dart:io';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'package:sci_tercen_client/sci_client_base.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';
import 'package:sci_http_client/http_io_client.dart';
import 'package:sci_http_client/http_client.dart' as http_api;
import 'helper.dart';

void main(List<String> args) async {
  // Initialize IO HTTP client (required before any HTTP calls)
  http_api.HttpClient.setCurrent(HttpIOClient());

  var factory = await initFactory();

  // --- Resolve workflow ID ---
  String? workflowId = args.isNotEmpty ? args.first : Platform.environment['WORKFLOW_ID'];

  if (workflowId == null || workflowId.isEmpty) {
    print('No WORKFLOW_ID set — searching for first workflow...');
    workflowId = await _findFirstWorkflow(factory);
    if (workflowId == null) {
      print('ERROR: No workflows found in any project.');
      return;
    }
  }

  print('--- Fetching workflow: $workflowId ---\n');

  // --- Fetch and transform ---
  try {
    final result = await getWorkflowGraph(factory, workflowId);
    final encoder = JsonEncoder.withIndent('  ');
    print(encoder.convert(result));
    print('\n--- Summary ---');
    final nodes = result['nodes'] as List;
    final edges = result['edges'] as List;
    print('Workflow: ${result['name']}');
    print('Nodes: ${nodes.length}');
    print('Edges: ${edges.length}');

    // Validate node fields
    if (nodes.isNotEmpty) {
      final first = nodes.first as Map<String, dynamic>;
      final requiredKeys = ['id', 'label', 'x', 'y', 'width', 'height', 'shape', 'icon', 'iconColor'];
      final missing = requiredKeys.where((k) => !first.containsKey(k)).toList();
      if (missing.isNotEmpty) {
        print('WARNING: First node missing keys: $missing');
      } else {
        print('Node schema: OK (all required keys present)');
      }
      // Check for zero-size nodes
      final zeroSize = nodes.where((n) {
        final nm = n as Map<String, dynamic>;
        return (nm['width'] as num) == 0 || (nm['height'] as num) == 0;
      }).length;
      if (zeroSize > 0) {
        print('WARNING: $zeroSize node(s) have zero width or height');
      }
    }

    // Validate edges reference existing node IDs
    final nodeIds = nodes.map((n) => (n as Map)['id'] as String).toSet();
    for (final e in edges) {
      final em = e as Map<String, dynamic>;
      if (!nodeIds.contains(em['from'])) {
        print('WARNING: Edge "from" references unknown node: ${em['from']}');
      }
      if (!nodeIds.contains(em['to'])) {
        print('WARNING: Edge "to" references unknown node: ${em['to']}');
      }
    }
  } catch (e, st) {
    print('ERROR: $e');
    print(st);
  }
}

/// Replicates ServiceCallDispatcher._getWorkflowGraph exactly.
Future<Map<String, dynamic>> getWorkflowGraph(
    ServiceFactoryBase factory, String workflowId) async {
  final workflow = await factory.workflowService.get(workflowId);
  final wfJson =
      Map<String, dynamic>.from(factory.workflowService.toJson(workflow));
  final steps = wfJson['steps'] as List? ?? [];
  final links = wfJson['links'] as List? ?? [];
  final wfName = wfJson['name'] as String? ?? workflowId;

  final nodes = <Map<String, dynamic>>[];
  for (final s in steps) {
    final sm = Map<String, dynamic>.from(s as Map);
    final kind = sm['kind'] as String? ?? '';
    final name = sm['name'] as String? ?? '';
    final id = sm['id'] as String? ?? '';
    final rect = sm['rectangle'] as Map? ?? {};
    final tl = rect['topLeft'] as Map? ?? {};
    final ext = rect['extent'] as Map? ?? {};
    final state = sm['state'] as Map? ?? {};
    final taskState =
        (state['taskState'] as Map?)?['kind'] as String? ?? 'InitState';

    nodes.add({
      'id': id,
      'label': name,
      'x': _toDouble(tl['x']),
      'y': _toDouble(tl['y']),
      'width': _toDouble(ext['x']),
      'height': _toDouble(ext['y'], fallback: 36),
      'shape': _stepKindToShape(kind),
      'icon': _stepKindToIcon(kind),
      'iconColor': _taskStateToColor(taskState),
      'fill': 'surface',
      'borderColor': 'outline',
      'subtitle': kind,
    });
  }

  final edges = <Map<String, String>>[];
  for (final l in links) {
    final lm = Map<String, dynamic>.from(l as Map);
    final outputId = lm['outputId'] as String? ?? '';
    final inputId = lm['inputId'] as String? ?? '';
    final fromStep = outputId.contains('-o-')
        ? outputId.substring(0, outputId.lastIndexOf('-o-'))
        : outputId;
    final toStep = inputId.contains('-i-')
        ? inputId.substring(0, inputId.lastIndexOf('-i-'))
        : inputId;
    if (fromStep.isNotEmpty && toStep.isNotEmpty) {
      edges.add({'from': fromStep, 'to': toStep});
    }
  }

  return {'name': wfName, 'nodes': nodes, 'edges': edges};
}

/// Find first workflow in any project.
Future<String?> _findFirstWorkflow(ServiceFactoryBase factory) async {
  final docs = await factory.projectDocumentService
      .findProjectObjectsByLastModifiedDateStream(useFactory: true)
      .where((d) => d is sci.Workflow)
      .take(1)
      .toList();
  if (docs.isEmpty) return null;
  final wf = docs.first as sci.Workflow;
  print('Found workflow: "${wf.name}" (${wf.id}) in project ${wf.projectId}');
  return wf.id;
}

double _toDouble(dynamic v, {double fallback = 0}) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? fallback;
  return fallback;
}

String _stepKindToShape(String kind) => switch (kind) {
      'TableStep' => 'roundedRect',
      'DataStep' => 'roundedRect',
      'MeltStep' => 'hexagon',
      'JoinStep' => 'hexagon',
      'ViewStep' => 'circle',
      'InStep' => 'roundedSquare',
      'OutStep' => 'roundedSquare',
      'ExportStep' => 'roundedSquare',
      'WizardStep' => 'roundedRect',
      'GroupStep' => 'circle',
      _ => 'roundedRect',
    };

String _stepKindToIcon(String kind) => switch (kind) {
      'TableStep' => 'table',
      'DataStep' => 'cubes',
      'MeltStep' => 'shuffle',
      'JoinStep' => 'code-merge',
      'ViewStep' => 'eye',
      'InStep' => 'right-to-bracket',
      'OutStep' => 'right-from-bracket',
      'ExportStep' => 'right-from-bracket',
      'WizardStep' => 'wand-magic-sparkles',
      'GroupStep' => 'sitemap',
      _ => 'cubes',
    };

String _taskStateToColor(String taskState) => switch (taskState) {
      'DoneState' => 'success',
      'RunningState' => 'info',
      'RunningDependentState' => 'warning',
      'FailedState' => 'error',
      'CanceledState' => 'onSurfaceMuted',
      'PendingState' => 'onSurfaceMuted',
      _ => 'onSurfaceVariant',
    };


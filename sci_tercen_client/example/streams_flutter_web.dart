/// Flutter web app example using Tercen client stream extensions
/// This demonstrates integration in a real Flutter WASM web application

import 'package:flutter/material.dart';
import 'package:sci_tercen_client/sci_service_factory_web.dart';
import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart' as tercen;

void main() async {
  // Initialize Tercen service factory before running the app
  await createServiceFactoryForWebApp(
    // Token can come from URL parameters, local storage, or environment
    tercenToken: const String.fromEnvironment('TERCEN_TOKEN'),
    serviceUri: const String.fromEnvironment('SERVICE_URI', defaultValue: 'https://tercen.com'),
  );

  runApp(const TercenWebApp());
}

class TercenWebApp extends StatelessWidget {
  const TercenWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tercen Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProjectBrowserPage(),
    );
  }
}

/// Page that displays a list of projects using stream extensions
class ProjectBrowserPage extends StatefulWidget {
  const ProjectBrowserPage({Key? key}) : super(key: key);

  @override
  State<ProjectBrowserPage> createState() => _ProjectBrowserPageState();
}

class _ProjectBrowserPageState extends State<ProjectBrowserPage> {
  final List<Project> _projects = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  /// Load projects using stream extension
  Future<void> _loadProjects() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      var projectService = tercen.ServiceFactory().projectService;

      // Use stream extension to load projects
      await for (var project in projectService.findByIsPublicAndLastModifiedDateStream(
        startKeyIsPublic: true,
        endKeyIsPublic: true,
        descending: true,  // Most recent first
        useFactory: true,  // Get full Project objects
      )) {
        setState(() {
          _projects.add(project);
        });

        // Load in batches of 20
        if (_projects.length >= 20) break;
      }

      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tercen Projects'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProjects,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_projects.isEmpty) {
      return const Center(
        child: Text('No projects found'),
      );
    }

    return ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        var project = _projects[index];
        return ProjectCard(project: project);
      },
    );
  }
}

/// Widget to display a project card
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(projectId: project.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Modified: ${project.lastModifiedDate.value}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  if (project.isPublic)
                    const Chip(
                      label: Text('Public'),
                      backgroundColor: Colors.green,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Page showing project details with files
class ProjectDetailPage extends StatefulWidget {
  final String projectId;

  const ProjectDetailPage({Key? key, required this.projectId}) : super(key: key);

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final List<ProjectDocument> _documents = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  /// Load project documents using stream extension
  Future<void> _loadDocuments() async {
    try {
      var projectDocService = tercen.ServiceFactory().projectDocumentService;

      // Load all project objects (files, schemas, workflows)
      await for (var doc in projectDocService.findProjectObjectsByLastModifiedDateStream(
        startKeyProjectId: widget.projectId,
        endKeyProjectId: widget.projectId,
        descending: true,
        useFactory: true,  // Get concrete types
      )) {
        setState(() {
          _documents.add(doc);
        });
      }

      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading documents: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _documents.length,
              itemBuilder: (context, index) {
                var doc = _documents[index];
                return ListTile(
                  leading: _getIcon(doc),
                  title: Text(doc.name),
                  subtitle: Text(_getSubtitle(doc)),
                  trailing: Text(doc.lastModifiedDate.value),
                );
              },
            ),
    );
  }

  Icon _getIcon(ProjectDocument doc) {
    if (doc is FileDocument) {
      return const Icon(Icons.insert_drive_file);
    } else if (doc is TableSchema) {
      return const Icon(Icons.table_chart);
    } else if (doc is Workflow) {
      return const Icon(Icons.account_tree);
    }
    return const Icon(Icons.description);
  }

  String _getSubtitle(ProjectDocument doc) {
    if (doc is FileDocument) {
      return 'File • ${(doc.storageSize / 1024).toStringAsFixed(1)} KB';
    } else if (doc is TableSchema) {
      return 'Table • ${doc.nRows} rows × ${doc.columns.length} cols';
    } else if (doc is Workflow) {
      return 'Workflow • ${doc.steps.length} steps';
    }
    return doc.kind;
  }
}

import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  var factory = await initFactory();

  // --- Subscribe to a channel and receive PatchRecords ---
  // PatchRecords track incremental changes to objects on a channel.
  // Typical use: watch a task's channel for real-time object updates.

  // var channelId = task.channelId;

  // --- Find patch records by channel and sequence (stream) ---
  var patchRecords = await factory.patchRecordService
      .findByChannelIdAndSequenceStream(
          startKeyChannelId: 'some-channel-id',
          endKeyChannelId: 'some-channel-id',
          descending: false)
      .take(10)
      .toList();
  print('patch records: ${patchRecords.length}');

  // --- Apply PatchRecords to an object ---
  // PatchRecords.apply() mutates the object in-place with the changes.
  // for (var pr in patchRecords) {
  //   project = pr.apply(project);
  // }

  // --- Inspect PatchRecords ---
  for (var pr in patchRecords) {
    print('s=${pr.s} records=${pr.rs.length}');
    for (var r in pr.rs) {
      print('  path=${r.path} type=${r.type}');
    }
  }

  // --- Error recovery pattern: refetch + retry ---
  // When applying patches out of order or to stale objects,
  // refetch the object and replay from the correct sequence.
  // var obj = await factory.projectService.get(projectId);
  // var patches = await factory.patchRecordService
  //     .findByChannelIdAndSequenceStream(
  //         startKeyChannelId: channelId,
  //         endKeyChannelId: channelId,
  //         startKeySequence: lastKnownSequence,
  //         descending: false)
  //     .toList();
  // for (var pr in patches) {
  //   obj = pr.apply(obj);
  // }

  // --- Check for FailedState in patch data ---
  // for (var pr in patchRecords) {
  //   for (var r in pr.rs) {
  //     if (r.path.contains('state') && r.data.contains('FailedState')) {
  //       print('task failed!');
  //     }
  //   }
  // }
}

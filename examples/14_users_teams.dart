import 'package:sci_tercen_client/sci_client.dart';
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  var factory = await initFactory();

  // --- Find user by email (stream) ---
  var users = await factory.userService
      .findUserByEmailStream(startKeyEmail: 'admin')
      .take(5)
      .toList();
  print('users: ${users.length}');
  for (var u in users) {
    print('  ${u.name} (${u.id})');
  }

  // --- hasUserName ---
  var exists = await factory.userService.hasUserName('admin');
  print('hasUserName "admin": $exists');

  // --- Token management ---
  if (users.isNotEmpty) {
    var user = users.first;

    // Create token valid for 1 hour
    var token = await factory.userService.createToken(user.id, 3600);
    print('token: ${token.substring(0, 20)}...');

    var valid = await factory.userService.isTokenValid(token);
    print('valid: $valid');

    // --- User profiles ---
    var profiles = await factory.userService.profiles(user.id);
    print('profiles: ${profiles.toJson()}');
  }

  // --- Find teams by owner (stream) ---
  var teams = await factory.teamService
      .findTeamByOwnerStream()
      .take(5)
      .toList();
  print('teams: ${teams.length}');
  for (var t in teams) {
    print('  ${t.name} owner=${t.acl.owner}');
  }

  // --- Team profiles ---
  if (teams.isNotEmpty) {
    var teamProfiles =
        await factory.teamService.profiles(teams.first.id);
    print('team profiles: ${teamProfiles.toJson()}');
  }
}

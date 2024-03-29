library sci.service;

export 'config.dart';
export 'package:sci_http_client/error.dart';
export 'sci_acl.dart';
import 'dart:async';
import 'config.dart';

// import 'package:sci_util/src/util/path/long_path.dart' as lpath;

import 'sci_acl.dart';

// String value2LongPath(String value) => lpath.longPath(value);

class ServiceEvent {}

class IdRevServiceEvent extends ServiceEvent {
  String? id;
  String? rev;
}

class CreatedServiceEvent<T> extends ServiceEvent {
  T object;
  CreatedServiceEvent(this.object);
}

class DeleteServiceEvent extends IdRevServiceEvent {}

class UpdateServiceEvent<T> extends ServiceEvent {
  T object;
  UpdateServiceEvent(this.object);
}

abstract class Service<T> {
  DomainConfig get config;
  //relative uri
  Uri get uri;
  //full path uri
  Uri getServiceUri(Uri uri) => Uri.base;
  String get serviceName;

  Future<T> create(T object, {AclContext? aclContext});
  Future<T> get(String id, {bool useFactory = true, AclContext? aclContext});
  Future<T?> getNoneMatchRev(String id, String ifNoneMatchRev,
      {bool useFactory = true, AclContext? aclContext});
  Future<List<T>> list(List<String> ids,
      {bool useFactory = true, AclContext? aclContext});

  Future<List<T?>> listNotFound(List<String> ids,
      {bool useFactory = true, AclContext? aclContext});

  Future<String> update(T object, {AclContext? aclContext});

  Future delete(String id, String rev,
      {AclContext? aclContext, bool force = false});
  Future deleteObject(T object,
      {AclContext? aclContext, bool checkRef = true, bool force = false});
  Future deleteObjects(List<T> objects,
      {AclContext? aclContext, bool checkRef = true, bool force = false});
  Future<String> patch(PatchCommands commands, {AclContext? aclContext});
  T fromJson(Map m, {bool useFactory = true});
  Map toJson(T object);
}

class PatchCommands {
  late final String id;
  late final String rev;
  final List<PatchCommand> commands;

  PatchCommands(this.id, this.rev, this.commands);

  factory PatchCommands.fromJson(Map m) {
    var commands = (m['commands'] as List)
        .map((each) => PatchCommand.fromJson(each as Map))
        .toList();
    return PatchCommands(m['id'] as String, m['rev'] as String, commands);
  }

  Map toJson() => {
        'id': id,
        'rev': rev,
        'commands': commands.map((each) => each.toJson()).toList()
      };
}

class PatchCommand {
  final String? path;
  final dynamic value;

  PatchCommand(this.path, this.value);

  factory PatchCommand.fromJson(Map m) =>
      PatchCommand(m['path'] as String?, m['value']);

  Map toJson() => {'path': path, 'value': value};
}

import 'package:collection/collection.dart' show IterableExtension;
import 'package:logging/logging.dart';
import 'dart:convert';

class HostConfig {
  String domain;
  String db_prefix;
  List<String> hosts;
  Config config;

  HostConfig(this.domain, this.hosts, this.db_prefix, this.config);

  HostConfig copy() {
    return HostConfig(domain, hosts, db_prefix, config.copy());
  }

  Map asMap() {
    return {
      'domain': domain,
      'hosts': hosts,
      'db_prefix': db_prefix,
      'config': config.asMap()
    };
  }
}

class DomainConfig {
  static Logger logger = Logger('DomainConfig');
  static DomainConfig? _CURRENT;
  late Map<String, HostConfig> _data;

  Config _common;

  factory DomainConfig([DomainConfig? config]) {
    if (config != null) _CURRENT = config;
    _CURRENT ??= DomainConfig._();
    return _CURRENT!;
  }

  Map asMap() {
    var mm = Map.from(_common.asMap());
    mm['configs'] = _data.values.map((e) => e.asMap()).toList();
    return mm;
  }

  DomainConfig._() : _common = Config._() {
    _data = {};
  }

  DomainConfig copy() {
    return DomainConfig._()
      .._common = _common.copy()
      .._data =
          Map.from(_data.map((key, value) => MapEntry(key, value.copy())));
  }

  String domainForHost(String host) {
    var hostConfig = _data.values
        .firstWhereOrNull((element) => element.hosts.contains(host));
    if (hostConfig == null) throw 'config not found for host $host';
    return hostConfig.domain;
  }

  void initializeFrom(Map m) {
    var commonMap = json.decode(json.encode(m)) as Map;
    var configs = commonMap['configs'] as List?;
    commonMap.remove('configs');

    common.addAll(commonMap);

    _common = common;

    if (configs == null || configs.isEmpty) {
      var config = Config._()..addAll(common.asMap());
      var dbPrefix = '';
      var hostConfig = HostConfig('', ['127.0.0.1'], dbPrefix, config);
      _data[hostConfig.domain] = hostConfig;
    } else {
      for (var hConfig in configs) {
        var config = Config._()..addAll(common.asMap());

        var dbPrefix = hConfig['db_prefix'] as String?;
        dbPrefix ??= hConfig['domain'] as String;
        var hostConfig = HostConfig(
            hConfig['domain'] as String,
            (hConfig['hosts'] as List).cast<String>().toList(),
            dbPrefix,
            config..override(hConfig['config'] as Map?));
        _data[hostConfig.domain] = hostConfig;
      }
    }
  }

  void initialize(Map m, Config defaultConfig) {
    var common = Config._()..addAll(defaultConfig.asMap());
    // deep copy
    var commonMap = json.decode(json.encode(m)) as Map?;
    List? configs;

    if (commonMap != null) {
      configs = commonMap['configs'] as List?;
      commonMap.remove('configs');
      common.override(commonMap);
    }

    _common = common;

    if (configs == null || configs.isEmpty) {
      var config = Config._()..addAll(this.common.asMap());
      var dbPrefix = '';
      var hostConfig = HostConfig('', ['127.0.0.1'], dbPrefix, config);
      _data[hostConfig.domain] = hostConfig;
    } else {
      for (var hConfig in configs) {
        var config = Config._()..addAll(this.common.asMap());
        var dbPrefix = hConfig['domain'] as String;
        var hostConfig = HostConfig(
            hConfig['domain'] as String,
            (hConfig['hosts'] as List).cast<String>().toList(),
            dbPrefix,
            config..override(hConfig['config'] as Map?));
        _data[hostConfig.domain] = hostConfig;
      }
    }
  }

  Config get common => _common;

  Config getConfig(String domain) {
    if (domain == 'common') return common;
    var hostConfig = _data[domain];
    if (hostConfig == null) throw 'Domain not found : $domain';
    return hostConfig.config;
  }

  Iterable<String> get domains => configs.keys.cast<String>();
  Iterable<HostConfig> get hostConfigs => _data.values;

  HostConfig? getHostConfigForDomain(String domain) => _data[domain];

  Map<String, Config> get configs =>
      _data.map((key, value) => MapEntry(key, value.config));
}

class Config {
  static Logger logger = Logger('Config');

  static Config? _CURRENT;
  Map _data;
  factory Config([Config? config]) {
    if (config != null) _CURRENT = config;
    _CURRENT ??= Config._();
    return _CURRENT!;
  }

  Config._() : _data = {};

  void initLogger() {
    var strLogLevel = this['tercen.log.level'] ?? this['log.level'];

    strLogLevel ??= '0';

    var logLevel = int.parse(strLogLevel);
    var level = Level.LEVELS.firstWhere((l) => l.value == logLevel);
    Logger.root.level = level;

    Logger.root.onRecord.listen((LogRecord rec) {
      print(
          '${rec.time} : ${rec.level.name} : ${rec.loggerName} : ${rec.message}');
      if (rec.error != null) {
        print(rec.error);
      }
      if (rec.stackTrace != null) {
        print(rec.stackTrace);
      }
    });
  }

  void override(Map? mm) {
    // deep copy
    var m = json.decode(json.encode(mm));

    m.keys.forEach((key) {
      if (!_data.containsKey(key)) {
        // logger.warning('override -- failed -- key ${key} is unknown');
      }
    });

    for (var key in _data.keys) {
      if (m.containsKey(key)) {
        // logger.config('override -- key ${key} is overrided');
        _data[key] = m[key];
      }
    }
  }

  void initialize(Map m) {
    // deep copy
    _data = json.decode(json.encode(m));
  }

  void addAll(Map m) {
    m.forEach((k, v) {
      _data[k] = v;
    });
  }

  operator [](String name) {
    return _data[name];
  }

  Map asMap() => Map.from(_data);

  Config copy() => Config._()..initialize(asMap());
}

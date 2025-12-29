part of sci_model_base;

class ZipEntryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.size_DP,
    Vocabulary.compressedSize_DP,
    Vocabulary.isDirectory_DP,
    Vocabulary.lastModified_DP,
    Vocabulary.crc32_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  int _size;
  int _compressedSize;
  bool _isDirectory;
  int _lastModified;
  int _crc32;

  ZipEntryBase()
      : _name = "",
        _size = 0,
        _compressedSize = 0,
        _isDirectory = true,
        _lastModified = 0,
        _crc32 = 0;
  ZipEntryBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _size = base.defaultValue(
            m[Vocabulary.size_DP] as int?, base.int_DefaultFactory),
        _compressedSize = base.defaultValue(
            m[Vocabulary.compressedSize_DP] as int?, base.int_DefaultFactory),
        _isDirectory = base.defaultValue(
            m[Vocabulary.isDirectory_DP] as bool?, base.bool_DefaultFactory),
        _lastModified = base.defaultValue(
            m[Vocabulary.lastModified_DP] as int?, base.int_DefaultFactory),
        _crc32 = base.defaultValue(
            m[Vocabulary.crc32_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ZipEntry_CLASS, m);
  }

  static ZipEntry createFromJson(Map m) => ZipEntryBase.fromJson(m);
  static ZipEntry fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ZipEntry_CLASS:
        return ZipEntry.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ZipEntry_CLASS;
  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  int get size => _size;

  set size(int $o) {
    if ($o == _size) return;
    var $old = _size;
    _size = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.size_DP, $old, _size));
    }
  }

  int get compressedSize => _compressedSize;

  set compressedSize(int $o) {
    if ($o == _compressedSize) return;
    var $old = _compressedSize;
    _compressedSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.compressedSize_DP, $old, _compressedSize));
    }
  }

  bool get isDirectory => _isDirectory;

  set isDirectory(bool $o) {
    if ($o == _isDirectory) return;
    var $old = _isDirectory;
    _isDirectory = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isDirectory_DP, $old, _isDirectory));
    }
  }

  int get lastModified => _lastModified;

  set lastModified(int $o) {
    if ($o == _lastModified) return;
    var $old = _lastModified;
    _lastModified = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.lastModified_DP, $old, _lastModified));
    }
  }

  int get crc32 => _crc32;

  set crc32(int $o) {
    if ($o == _crc32) return;
    var $old = _crc32;
    _crc32 = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.crc32_DP, $old, _crc32));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.size_DP:
        return size;
      case Vocabulary.compressedSize_DP:
        return compressedSize;
      case Vocabulary.isDirectory_DP:
        return isDirectory;
      case Vocabulary.lastModified_DP:
        return lastModified;
      case Vocabulary.crc32_DP:
        return crc32;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.size_DP:
        size = $value as int;
        return;
      case Vocabulary.compressedSize_DP:
        compressedSize = $value as int;
        return;
      case Vocabulary.isDirectory_DP:
        isDirectory = $value as bool;
        return;
      case Vocabulary.lastModified_DP:
        lastModified = $value as int;
        return;
      case Vocabulary.crc32_DP:
        crc32 = $value as int;
        return;
      default:
        super.set($name, $value);
    }
  }

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ZipEntry copy() => ZipEntry.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ZipEntry_CLASS;
    if (subKind != null && subKind != Vocabulary.ZipEntry_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.size_DP] = size;
    m[Vocabulary.compressedSize_DP] = compressedSize;
    m[Vocabulary.isDirectory_DP] = isDirectory;
    m[Vocabulary.lastModified_DP] = lastModified;
    m[Vocabulary.crc32_DP] = crc32;
    return m;
  }
}

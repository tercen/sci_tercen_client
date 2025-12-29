part of sci_model_base;

class ZipSummaryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.totalEntries_DP,
    Vocabulary.totalSize_DP,
    Vocabulary.totalCompressedSize_DP,
    Vocabulary.fileCount_DP,
    Vocabulary.directoryCount_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _totalEntries;
  int _totalSize;
  int _totalCompressedSize;
  int _fileCount;
  int _directoryCount;

  ZipSummaryBase()
      : _totalEntries = 0,
        _totalSize = 0,
        _totalCompressedSize = 0,
        _fileCount = 0,
        _directoryCount = 0;
  ZipSummaryBase.json(Map m)
      : _totalEntries = base.defaultValue(
            m[Vocabulary.totalEntries_DP] as int?, base.int_DefaultFactory),
        _totalSize = base.defaultValue(
            m[Vocabulary.totalSize_DP] as int?, base.int_DefaultFactory),
        _totalCompressedSize = base.defaultValue(
            m[Vocabulary.totalCompressedSize_DP] as int?,
            base.int_DefaultFactory),
        _fileCount = base.defaultValue(
            m[Vocabulary.fileCount_DP] as int?, base.int_DefaultFactory),
        _directoryCount = base.defaultValue(
            m[Vocabulary.directoryCount_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ZipSummary_CLASS, m);
  }

  static ZipSummary createFromJson(Map m) => ZipSummaryBase.fromJson(m);
  static ZipSummary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ZipSummary_CLASS:
        return ZipSummary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ZipSummary_CLASS;
  int get totalEntries => _totalEntries;

  set totalEntries(int $o) {
    if ($o == _totalEntries) return;
    var $old = _totalEntries;
    _totalEntries = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.totalEntries_DP, $old, _totalEntries));
    }
  }

  int get totalSize => _totalSize;

  set totalSize(int $o) {
    if ($o == _totalSize) return;
    var $old = _totalSize;
    _totalSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.totalSize_DP, $old, _totalSize));
    }
  }

  int get totalCompressedSize => _totalCompressedSize;

  set totalCompressedSize(int $o) {
    if ($o == _totalCompressedSize) return;
    var $old = _totalCompressedSize;
    _totalCompressedSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.totalCompressedSize_DP, $old, _totalCompressedSize));
    }
  }

  int get fileCount => _fileCount;

  set fileCount(int $o) {
    if ($o == _fileCount) return;
    var $old = _fileCount;
    _fileCount = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.fileCount_DP, $old, _fileCount));
    }
  }

  int get directoryCount => _directoryCount;

  set directoryCount(int $o) {
    if ($o == _directoryCount) return;
    var $old = _directoryCount;
    _directoryCount = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.directoryCount_DP, $old, _directoryCount));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.totalEntries_DP:
        return totalEntries;
      case Vocabulary.totalSize_DP:
        return totalSize;
      case Vocabulary.totalCompressedSize_DP:
        return totalCompressedSize;
      case Vocabulary.fileCount_DP:
        return fileCount;
      case Vocabulary.directoryCount_DP:
        return directoryCount;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.totalEntries_DP:
        totalEntries = $value as int;
        return;
      case Vocabulary.totalSize_DP:
        totalSize = $value as int;
        return;
      case Vocabulary.totalCompressedSize_DP:
        totalCompressedSize = $value as int;
        return;
      case Vocabulary.fileCount_DP:
        fileCount = $value as int;
        return;
      case Vocabulary.directoryCount_DP:
        directoryCount = $value as int;
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
  ZipSummary copy() => ZipSummary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ZipSummary_CLASS;
    if (subKind != null && subKind != Vocabulary.ZipSummary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.totalEntries_DP] = totalEntries;
    m[Vocabulary.totalSize_DP] = totalSize;
    m[Vocabulary.totalCompressedSize_DP] = totalCompressedSize;
    m[Vocabulary.fileCount_DP] = fileCount;
    m[Vocabulary.directoryCount_DP] = directoryCount;
    return m;
  }
}

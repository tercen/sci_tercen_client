part of sci_model_base;

class DocumentBase extends PersistentObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.description_DP,
    Vocabulary.name_DP,
    Vocabulary.acl_OP,
    Vocabulary.createdDate_OP,
    Vocabulary.lastModifiedDate_OP,
    Vocabulary.urls_OP,
    Vocabulary.tags_DP,
    Vocabulary.meta_OP,
    Vocabulary.url_OP,
    Vocabulary.version_DP,
    Vocabulary.isPublic_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _description;
  String _name;
  Acl _acl;
  Date _createdDate;
  Date _lastModifiedDate;
  final base.ListChanged<Url> urls;
  final base.ListChangedBase<String> tags;
  final base.ListChanged<Pair> meta;
  Url _url;
  String _version;
  bool _isPublic;

  DocumentBase()
      : _description = "",
        _name = "",
        tags = base.ListChangedBase<String>(),
        _version = "",
        _isPublic = true,
        _acl = Acl(),
        _createdDate = Date(),
        _lastModifiedDate = Date(),
        urls = base.ListChanged<Url>(),
        meta = base.ListChanged<Pair>(),
        _url = Url() {
    tags.parent = this;
    _acl.parent = this;
    _createdDate.parent = this;
    _lastModifiedDate.parent = this;
    urls.parent = this;
    meta.parent = this;
    _url.parent = this;
  }

  DocumentBase.json(Map m)
      : _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        tags = base.ListChangedBase<String>(m[Vocabulary.tags_DP] as List?),
        _version = base.defaultValue(
            m[Vocabulary.version_DP] as String?, base.String_DefaultFactory),
        _isPublic = base.defaultValue(
            m[Vocabulary.isPublic_DP] as bool?, base.bool_DefaultFactory),
        _acl = (m[Vocabulary.acl_OP] as Map?) == null
            ? Acl()
            : AclBase.fromJson(m[Vocabulary.acl_OP] as Map),
        _createdDate = (m[Vocabulary.createdDate_OP] as Map?) == null
            ? Date()
            : DateBase.fromJson(m[Vocabulary.createdDate_OP] as Map),
        _lastModifiedDate = (m[Vocabulary.lastModifiedDate_OP] as Map?) == null
            ? Date()
            : DateBase.fromJson(m[Vocabulary.lastModifiedDate_OP] as Map),
        urls = base.ListChanged<Url>.from(
            m[Vocabulary.urls_OP] as List?, UrlBase.createFromJson),
        meta = base.ListChanged<Pair>.from(
            m[Vocabulary.meta_OP] as List?, PairBase.createFromJson),
        _url = (m[Vocabulary.url_OP] as Map?) == null
            ? Url()
            : UrlBase.fromJson(m[Vocabulary.url_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Document_CLASS, m);
    tags.parent = this;
    _acl.parent = this;
    _createdDate.parent = this;
    _lastModifiedDate.parent = this;
    urls.parent = this;
    meta.parent = this;
    _url.parent = this;
  }

  static Document createFromJson(Map m) => DocumentBase.fromJson(m);
  static Document fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Document_CLASS:
        return Document.json(m);
      case Vocabulary.Team_CLASS:
        return Team.json(m);
      case Vocabulary.RSourceLibrary_CLASS:
        return RSourceLibrary.json(m);
      case Vocabulary.RenvInstalledLibrary_CLASS:
        return RenvInstalledLibrary.json(m);
      case Vocabulary.ShinyOperator_CLASS:
        return ShinyOperator.json(m);
      case Vocabulary.DockerWebAppOperator_CLASS:
        return DockerWebAppOperator.json(m);
      case Vocabulary.DockerOperator_CLASS:
        return DockerOperator.json(m);
      case Vocabulary.ROperator_CLASS:
        return ROperator.json(m);
      case Vocabulary.WebAppOperator_CLASS:
        return WebAppOperator.json(m);
      case Vocabulary.GitOperator_CLASS:
        return GitOperator.json(m);
      case Vocabulary.CubeQueryTableSchema_CLASS:
        return CubeQueryTableSchema.json(m);
      case Vocabulary.TableSchema_CLASS:
        return TableSchema.json(m);
      case Vocabulary.ComputedTableSchema_CLASS:
        return ComputedTableSchema.json(m);
      case Vocabulary.FileDocument_CLASS:
        return FileDocument.json(m);
      case Vocabulary.FolderDocument_CLASS:
        return FolderDocument.json(m);
      case Vocabulary.Schema_CLASS:
        return Schema.json(m);
      case Vocabulary.Workflow_CLASS:
        return Workflow.json(m);
      case Vocabulary.User_CLASS:
        return User.json(m);
      case Vocabulary.RLibrary_CLASS:
        return RLibrary.json(m);
      case Vocabulary.Operator_CLASS:
        return Operator.json(m);
      case Vocabulary.WorkerEndpoint_CLASS:
        return WorkerEndpoint.json(m);
      case Vocabulary.ProjectDocument_CLASS:
        return ProjectDocument.json(m);
      case Vocabulary.Project_CLASS:
        return Project.json(m);
      case Vocabulary.SubscriptionPlan_CLASS:
        return SubscriptionPlan.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Document_CLASS;
  String get description => _description;

  set description(String $o) {
    if ($o == _description) return;
    var $old = _description;
    _description = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.description_DP, $old, _description));
    }
  }

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

  String get version => _version;

  set version(String $o) {
    if ($o == _version) return;
    var $old = _version;
    _version = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.version_DP, $old, _version));
    }
  }

  bool get isPublic => _isPublic;

  set isPublic(bool $o) {
    if ($o == _isPublic) return;
    var $old = _isPublic;
    _isPublic = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isPublic_DP, $old, _isPublic));
    }
  }

  Acl get acl => _acl;

  set acl(Acl $o) {
    if ($o == _acl) return;
    _acl.parent = null;
    $o.parent = this;
    var $old = _acl;
    _acl = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.acl_OP, $old, _acl));
    }
  }

  Date get createdDate => _createdDate;

  set createdDate(Date $o) {
    if ($o == _createdDate) return;
    _createdDate.parent = null;
    $o.parent = this;
    var $old = _createdDate;
    _createdDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.createdDate_OP, $old, _createdDate));
    }
  }

  Date get lastModifiedDate => _lastModifiedDate;

  set lastModifiedDate(Date $o) {
    if ($o == _lastModifiedDate) return;
    _lastModifiedDate.parent = null;
    $o.parent = this;
    var $old = _lastModifiedDate;
    _lastModifiedDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.lastModifiedDate_OP, $old, _lastModifiedDate));
    }
  }

  Url get url => _url;

  set url(Url $o) {
    if ($o == _url) return;
    _url.parent = null;
    $o.parent = this;
    var $old = _url;
    _url = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.url_OP, $old, _url));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.description_DP:
        return description;
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.acl_OP:
        return acl;
      case Vocabulary.createdDate_OP:
        return createdDate;
      case Vocabulary.lastModifiedDate_OP:
        return lastModifiedDate;
      case Vocabulary.urls_OP:
        return urls;
      case Vocabulary.tags_DP:
        return tags;
      case Vocabulary.meta_OP:
        return meta;
      case Vocabulary.url_OP:
        return url;
      case Vocabulary.version_DP:
        return version;
      case Vocabulary.isPublic_DP:
        return isPublic;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.description_DP:
        description = $value as String;
        return;
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.tags_DP:
        tags.setValues($value as Iterable<String>);
        return;
      case Vocabulary.version_DP:
        version = $value as String;
        return;
      case Vocabulary.isPublic_DP:
        isPublic = $value as bool;
        return;
      case Vocabulary.acl_OP:
        acl = $value as Acl;
        return;
      case Vocabulary.createdDate_OP:
        createdDate = $value as Date;
        return;
      case Vocabulary.lastModifiedDate_OP:
        lastModifiedDate = $value as Date;
        return;
      case Vocabulary.urls_OP:
        urls.setValues($value as Iterable<Url>);
        return;
      case Vocabulary.meta_OP:
        meta.setValues($value as Iterable<Pair>);
        return;
      case Vocabulary.url_OP:
        url = $value as Url;
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
  Document copy() => Document.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Document_CLASS;
    if (subKind != null && subKind != Vocabulary.Document_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.description_DP] = description;
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.acl_OP] = acl.toJson();
    m[Vocabulary.createdDate_OP] = createdDate.toJson();
    m[Vocabulary.lastModifiedDate_OP] = lastModifiedDate.toJson();
    m[Vocabulary.urls_OP] = urls.toJson();
    m[Vocabulary.tags_DP] = tags;
    m[Vocabulary.meta_OP] = meta.toJson();
    m[Vocabulary.url_OP] = url.toJson();
    m[Vocabulary.version_DP] = version;
    m[Vocabulary.isPublic_DP] = isPublic;
    return m;
  }
}

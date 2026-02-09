part of sci_model;

typedef RelationVisitor = void Function(Relation relation);

abstract class TblRelation implements Relation {
  Future<int> getNRows();
  Future<String> getName();
  Future<Table> select(List<Attribute> attributes, int offset, int limit);
}

class Relation extends RelationBase {
  static const String DocumentIdAlias = 'documentId';
  static const String DocumentId = '.documentId';

  static const String RIDS = '_rids';
  static const String TLB_ID = '.tlbId';
  static const String UINT64 = "uint64";
  static const String TLB_INDEX = '.tlbIdx';

  static Relation createFromJson(Map m) => RelationBase.fromJson(m);
  Relation() : super();
  Relation.json(Map m) : super.json(m);

  String? findDocumentId(String aliasDocumentId) {
    for (var inMemoryRelation in inMemoryRelations) {
      var tbl = inMemoryRelation.inMemoryTable;
      var documentIds = tbl.columns
          .where((element) => element.type == 'string')
          .firstWhereOrNull((element) => element.name == Relation.DocumentId);
      var documentAliasIds = tbl.columns
          .where((element) => element.type == 'string')
          .firstWhereOrNull(
              (element) => element.name == Relation.DocumentIdAlias);
      if (documentIds != null && documentAliasIds != null) {
        var index = (documentAliasIds.values as List)
            .cast<String>()
            .indexOf(aliasDocumentId);
        if (index >= 0) {
          return (documentIds.values as List).cast<String>().elementAt(index);
        }
      }
    }
    return null;
  }

  void visit(RelationVisitor visitor) {
    visitor(this);
  }

  GroupByRelation groupBy(Iterable<String> group) {
    return GroupByRelation()
      ..id = 'group_$id'
      ..relation = this
      ..group.addAll(group);
  }

  Relation rename(Iterable<String> inNames, Iterable<String> outNames) {
    return RenameRelation()
      ..id = 'rename_$id'
      ..relation = this
      ..inNames.addAll(inNames)
      ..outNames.addAll(outNames);
  }

  Relation copyNoRef() => throw 'not impl';

  // Future<Relation> renameRids({String ridsName = 'rowId'}) async {
  //   var attrs = (await getAttributeNames())
  //       .where((name) => !(name.endsWith('.$RIDS') || name.endsWith(TLB_ID)));
  //
  //   print("$this -- renameRids -- attrs ${attrs.toList()}");
  //
  //   var relationId = this is ReferenceRelation
  //       ? (this as ReferenceRelation).relation.id
  //       : id;
  //
  //   var inNames = List<String>.from(attrs);
  //   var outNames = List<String>.from(attrs);
  //
  //   if (!attrs.contains(ridsName) &&
  //       await hasAttributeName('$relationId.$RIDS')) {
  //     inNames.add('$relationId.$RIDS');
  //     outNames.add(ridsName);
  //   }
  //
  //   // String tableIdName = 'tableId';
  //   // if (!attrs.contains(tableIdName) &&
  //   //     await hasAttributeName('$relationId${tbl.AMTable.TLB_ID}')) {
  //   //   inNames.add('$relationId${tbl.AMTable.TLB_ID}');
  //   //   outNames.add(tableIdName);
  //   // }
  //
  //   return RenameRelation()
  //     ..id = 'rename_$id'
  //     ..relation = this
  //     ..inNames.addAll(inNames)
  //     ..outNames.addAll(outNames);
  // }

  // Future<Set<String>> getAttributeNames([List<Schema>? schemas]) async {
  //   var attrs = await getAttributes(schemas);
  //   return attrs.map((a) => a.name).toSet();
  // }

  // Future<Set<Attribute>> getUserAttributes([List<Schema>? schemas]) async {
  //   var attrs = await getAttributes(schemas);
  //   return attrs
  //       .where((element) => !(element.type == UINT64))
  //       .where((element) => !(element.type == 'string' &&
  //           element.name.startsWith('.'))) // isBinaryLike
  //       .where((element) => !element.name.endsWith(RIDS))
  //       .where((element) => !element.name.endsWith(TLB_ID))
  //       .where((element) => !element.name.endsWith(TLB_INDEX))
  //       .toSet();
  // }

  // Future<Set<Attribute>> getAttributes([List<Schema>? schemas]) async {
  //   schemas ??= (await api.ServiceFactory()
  //           .tableSchemaService
  //           .list(simpleRelationIds.toList()))
  //       .cast<Schema>()
  //       .toList();
  //   return getBasicAttributes(schemas);
  // }

  Future<Set<Attribute>> getBasicAttributes([List<Schema>? schemas]) async =>
      <Attribute>{};

  // Future<Iterable<Schema>> getSchemas() async => (await api.ServiceFactory()
  //         .tableSchemaService
  //         .list(simpleRelationIds.toList()))
  //     .cast<Schema>();

  Set<SimpleRelation> get simpleRelations => collect<SimpleRelation>();
  Set<InMemoryRelation> get inMemoryRelations => collect<InMemoryRelation>();
  Set<ReferenceRelation> get referenceRelations => collect<ReferenceRelation>();
  Set<Relation> get simpleAndReferenceRelations =>
      {...simpleRelations, ...referenceRelations};

  Set<TblRelation> get tblRelations => collect<TblRelation>();

  Set<String> get simpleAndReferenceRelationIds =>
      simpleAndReferenceRelations.map((r) => r.id).toSet();

  Set<String> get simpleRelationIds => simpleRelations.map((r) => r.id).toSet();

  Set<R> collect<R>() {
    var set = <R>{};
    visit((rel) {
      if (rel is R) set.add(rel as R);
    });
    return set;
  }

  Set<Relation> getRelations() {
    var set = <Relation>{};
    visit((rel) {
      set.add(rel);
    });
    return set;
  }

  // Future<bool> hasAttributeName(String name, [List<Schema>? schemas]) async {
  //   var attrs = await getAttributes(schemas);
  //   return attrs.any((a) => a.name == name);
  // }

  // Future<List<Attribute>> findAttributes(List<String> names,
  //     [List<Schema>? schemas]) async {
  //   var attrs = await getAttributes(schemas);
  //   return names.map((cname) {
  //     return attrs.firstWhere((a) => a.name == cname);
  //   }).toList();
  // }

  // Future<List<String>> findAttributeFullnames(List<String> names,
  //     [List<Schema>? schemas]) async {
  //   return (await findAttributes(names, schemas)).map((a) => a.name).toList();
  // }

  // Future<List<Relation>> findRelationByAttributeName(String name,
  //     [List<Schema>? schemas]) async {
  //   var rels = <Relation>[];
  //   for (var relation in getRelations()) {
  //     if (await relation.hasAttributeName(name, schemas)) rels.add(relation);
  //   }
  //
  //   return rels;
  // }

  List<Relation> getRelationByIds(List<String> ids) {
    var list = <Relation>[];
    visit((rel) {
      if (ids.contains(rel.id)) {
        list.add(rel);
      }
    });
    return list;
  }

  Map getMapForHash() {
    var relation = copy();

    if (!(relation is SimpleRelation || relation is InMemoryRelation)) {
      relation.id = '';
    }

    relation.visit((rel) {
      if (!(rel is SimpleRelation || rel is InMemoryRelation)) {
        rel.id = '';
      }
    });

    var map = relation.toJson();

    void _visitMap(Map map, Function(Map object) visitor) {
      visitor(map);
      map.forEach((key, value) {
        if (value is Map) {
          visitor(value);
          _visitMap(value, visitor);
        } else if (value is List) {
          value.whereType<Map>().forEach((element) {
            _visitMap(element, visitor);
          });
        }
      });
    }

    _visitMap(map, (Map m) {
      if (m[Vocabulary.KIND] == Vocabulary.JoinOperator_CLASS) {
        var joinType = m[Vocabulary.joinType_DP] as String;
        if (joinType.isEmpty) {
          m.remove(Vocabulary.joinType_DP);
        }
      }
    });

    return map;
  }
}

class RelationUtil {
  static bool hasPrefix(String name, String prefix) =>
      name.startsWith('$prefix.');

  static bool hasAnyPrefix(String name) => name.contains('.');

  static String? getColumnPrefix(String cname) {
    return getPrefix(cname);
  }

  static String? getPrefix(String cname) {
    var i = cname.indexOf('.');
    if (i < 0) return null;
    return cname.substring(0, i);
  }

  static Set<String?> getRelationIdsFromAttributes(List<String> cnames) {
    return cnames.map(getColumnPrefix).toSet();
  }

  static String? getTableIdFromColumnName(String cname) =>
      getColumnPrefix(cname);

  static String removePrefix1(String cname,
      {String Function(String)? noPrefix}) {
    noPrefix ??=
        (s) => throw 'Util removePrefix : column "$cname" has no prefix';
    var i = cname.indexOf('.');
    if (i < 0) return noPrefix(cname);
    return cname.substring(i + 1);
  }

  static List<String> removePrefix(List<String> cnames,
      {String Function(String)? noPrefix}) {
    noPrefix ??= (s) => throw 'Util removePrefix : column "$s" has no prefix';
    return cnames.map<String>((cname) {
      var i = cname.indexOf('.');
      if (i < 0) return noPrefix!(cname);
      return cname.substring(i + 1);
    }).toList();
  }

  static List<String> replacePrefix(String prefix, List<String> cnames) {
    return cnames.map((cname) {
      var i = cname.indexOf('.');
      if (i < 0) throw 'Util removePrefix : column "$cname" has no prefix';
      return '$prefix.${cname.substring(i + 1)}';
    }).toList();
  }

  static List<String> replacePrefix2(
      String odlPrefix, String newPrefix, List<String> cnames) {
    return cnames.map((cname) {
      if (hasPrefix(cname, odlPrefix)) {
        var i = cname.indexOf('.');
        return '$newPrefix.${cname.substring(i + 1)}';
      } else {
        return cname;
      }
    }).toList();
  }

  static String addPrefix1(String prefix, String cname) => '$prefix.$cname';

  static List<String> addPrefix(String prefix, List<String> cnames) =>
      cnames.map((cname) => addPrefix1(prefix, cname)).toList();

  static List<String> removeColumnPrefix(String tableId, List<String> cnames) {
    var tablePrefix = '$tableId.';
    return cnames.map((cname) {
      if (!cname.startsWith(tablePrefix)) {
        throw 'Util : column $cname has wrong prefix, expected $tablePrefix found $cname';
      }
      return cname.substring(tablePrefix.length);
    }).toList();
  }

  static List<String> replaceColumnPrefix(
      String tableId, String newTableId, List<String> cnames) {
    return prefixColumn(newTableId, removeColumnPrefix(tableId, cnames));
  }

  static List<String> prefixColumn(String tableId, List<String> cnames) {
    return cnames.map((cname) => '$tableId.$cname').toList();
  }

  // static void addTablePrefix(String tableId, tbl.AMTable table) {
  //   var tablePrefix = '$tableId.';
  //   for (var cname in table.columnNames) {
  //     table.renameColumn(cname, '$tablePrefix$cname');
  //   }
  // }
  //
  // static void removeTablePrefix(String tableId, tbl.AMTable table) {
  //   for (var cname in table.columnNames) {
  //     table.renameColumn(cname, removeColumnPrefix(tableId, [cname]).first);
  //   }
  // }
}

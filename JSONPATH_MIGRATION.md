# JSONPath Migration for sci_tercen_client

## Problem Statement

The `sci_tercen_client` package (version 1.7.0) uses an outdated XPath-style path parsing mechanism in the `PatchRecord.apply()` method, while the server (`sci_api_model`) has been updated to generate JSONPath-style paths (e.g., `$.meta`, `$.steps[?@.id=='xxx'].state.taskState`).

### Current Behavior

**Client (sci_tercen_client 1.7.0):**
```dart
void apply(base.Base rebuilt) {
  var path = this.path.split('/');  // Splits on '/'
  dynamic target = rebuilt;

  for (var i = 1; i < path.length - 1; i++) {
    target = target.get(path[i]);
  }
  // ... rest of apply logic
}
```

**Server (sci_api_model - current):**
Generates paths like:
- `$.meta` (JSONPath format)
- `$.steps[?@.id=='b4092d4e-be42-47f7-8382-46d519ddf63c'].computedRelation`
- `$.name`

### The Issue

When the client receives a PatchRecord with path `"$.meta"`:
1. Old code: `"$.meta".split('/')` → `["$.meta"]` (single element array)
2. Loop doesn't execute (length is 1)
3. Tries to call `rebuilt.get("$.meta")` (using the full path as property name)
4. **Error:** `Invalid argument: "$.meta"` because `"$.meta"` is not a valid property name

## Solution: Update sci_tercen_client with JsonPathParser

### Required Changes

#### 1. Copy JsonPathParser Utilities

Copy the following directory from `sci_api_model`:
```
FROM: sci/sci_api_model/lib/src/utils/json_path/
TO:   sci_tercen_client/sci_tercen_model/lib/src/utils/json_path/
```

This includes:
- `json_path_parser.dart` - Main parser with JSONPath and XPath backward compatibility
- `path_segment.dart` - Segment types (RootSegment, PropertySegment, ArrayIndexSegment, FilterSegment)

#### 2. Update patch_record.dart

**File:** `sci_tercen_client/sci_tercen_model/lib/src/model/impl/patch_record.dart`

**Current apply() method (OUTDATED):**
```dart
void apply(base.Base rebuilt) {
  var path = this.path.split('/');
  dynamic target = rebuilt;

  for (var i = 1; i < path.length - 1; i++) {
    target = target.get(path[i]);
  }

  if (type == SET_TYPE) {
    var value = json.decode(data);
    target.set(path[path.length - 1], SciObject.fromJson(value));
  }
  // ... rest of type handling
}
```

**New apply() method (UPDATED):**
```dart
void apply(base.Base rebuilt) {
  _initFromRecordType();

  // Parse path into segments using JsonPathParser
  var segments = JsonPathParser.parse(this.path);

  // Navigate to target, keeping parent for final operation
  dynamic target = rebuilt;
  PathSegment? lastSegment;

  for (var i = 1; i < segments.length - 1; i++) {
    target = segments[i].navigate(target);
  }

  lastSegment = segments.last;

  // Apply operation based on type
  if (type == SET_TYPE) {
    var value = json.decode(data);
    if (lastSegment is PropertySegment) {
      if (target is base.Base) {
        target.set(lastSegment.property, SciObject.fromJson(value));
      } else {
        throw 'SET_TYPE target must be Base object, got ${target.runtimeType}';
      }
    } else {
      throw 'SET_TYPE requires property segment as last segment';
    }
  } else if (type == LIST_REMOVE_TYPE) {
    // For list operations, target should be the list itself
    if (lastSegment is PropertySegment) {
      if (target is base.Base) {
        target = target.get(lastSegment.property);
      } else {
        throw 'LIST_REMOVE_TYPE target must be Base object to get property';
      }
    }
    var indexes = json.decode(data) as List;
    for (var index in indexes) {
      (target as List).remove((target)[index]);
    }
  } else if (type == LIST_ADD_TYPE) {
    if (lastSegment is PropertySegment) {
      if (target is base.Base) {
        target = target.get(lastSegment.property);
      } else {
        throw 'LIST_ADD_TYPE target must be Base object to get property';
      }
    }
    var list = json.decode(data) as List;
    for (var element in list) {
      (target as List).add(SciObject.fromJson(element));
    }
  } else if (type == LIST_CLEAR_TYPE) {
    if (lastSegment is PropertySegment) {
      if (target is base.Base) {
        target = target.get(lastSegment.property);
      } else {
        throw 'LIST_CLEAR_TYPE target must be Base object to get property';
      }
    }
    (target as List).clear();
  } else if (type == LIST_INSERT_TYPE) {
    if (lastSegment is PropertySegment) {
      if (target is base.Base) {
        target = target.get(lastSegment.property);
      } else {
        throw 'LIST_INSERT_TYPE target must be Base object to get property';
      }
    }
    var list = json.decode(data) as List;
    (target as List).insert(list[0], SciObject.fromJson(list[1]));
  } else {
    throw 'unsupported type';
  }
}
```

**Add import at the top of the file:**
```dart
import '../../utils/json_path/json_path_parser.dart';
import '../../utils/json_path/path_segment.dart';
```

#### 3. Update _initFromRecordType() Method

The `_initFromRecordType()` method needs to be updated to use `recordType.kind` instead of `recordType.getKind()`:

**Change lines 76 and 79:**
```dart
// OLD (BROKEN):
if (this.type.isEmpty &&
    this.data.isEmpty &&
    recordType.getKind() != "PatchRecordType") {
  // ...
} else if (recordType.getKind() == "PatchRecordType") {
  // ...
}

// NEW (FIXED):
if (this.type.isEmpty &&
    this.data.isEmpty &&
    recordType.kind != "PatchRecordType") {
  // ...
} else if (recordType.kind == "PatchRecordType") {
  // ...
}
```

#### 4. Update toJson() Override

The `toJson()` method needs to ensure both legacy (`t`, `d`) and new (`recordType`) formats are serialized:

**File:** `sci_tercen_client/sci_tercen_model/lib/src/model/impl/patch_record.dart`

**Add/Update the toJson() method:**
```dart
@override
Map toJson() {
  var m = super.toJson();
  // Ensure t and d are populated from recordType if empty
  if (m[Vocabulary.t_DP] == null || (m[Vocabulary.t_DP] as String).isEmpty) {
    if (recordType.kind != "PatchRecordType") {
      m[Vocabulary.t_DP] = recordType.legacyType;
      m[Vocabulary.d_DP] = recordType.toLegacyData();
    }
  }
  return m;
}
```

**Note:** The old version had this code which REMOVED the fields:
```dart
// OLD (DO NOT USE):
@override
Map toJson() {
  var m = super.toJson();
  // Remove deprecated fields
  m.remove(Vocabulary.t_DP);  // This breaks clients!
  m.remove(Vocabulary.d_DP);  // This breaks clients!
  return m;
}
```

#### 5. Export Utilities in Library File

**File:** `sci_tercen_client/sci_tercen_model/lib/sci_model.dart`

Add export for json_path utilities:
```dart
export 'src/utils/json_path/json_path_parser.dart';
export 'src/utils/json_path/path_segment.dart';
```

### Testing the Changes

After making these changes, test with the following scenarios:

#### Test 1: Simple Property Path
```dart
var workflow = Workflow();
var record = PatchRecord()
  ..p = '$.name'
  ..type = PatchRecord.SET_TYPE
  ..data = json.encode('test workflow');

record.apply(workflow);
expect(workflow.name, equals('test workflow'));
```

#### Test 2: List Operation
```dart
var workflow = Workflow()..addMeta('key1', 'value1');
var record = PatchRecord()
  ..p = '$.meta'
  ..type = PatchRecord.LIST_REMOVE_TYPE
  ..data = '[0]';

record.apply(workflow);
expect(workflow.meta.length, equals(0));
```

#### Test 3: Filter-Based Path
```dart
var workflow = Workflow();
workflow.addStep(DataStep());
var step = workflow.steps[0] as DataStep;

var record = PatchRecord()
  ..p = '\$.steps[?@.id==\'${step.id}\'].name'
  ..type = PatchRecord.SET_TYPE
  ..data = json.encode('Updated Step');

record.apply(workflow);
expect(step.name, equals('Updated Step'));
```

#### Test 4: Backward Compatibility with XPath
```dart
var workflow = Workflow();
var record = PatchRecord()
  ..p = '/name'  // Old XPath format
  ..type = PatchRecord.SET_TYPE
  ..data = json.encode('legacy test');

record.apply(workflow);
expect(workflow.name, equals('legacy test'));
```

### Publishing New Version

After making these changes:

1. **Update version in pubspec.yaml:**
   ```yaml
   version: 1.7.1  # or 1.8.0 for breaking changes
   ```

2. **Commit changes:**
   ```bash
   git add .
   git commit -m "feat: migrate PatchRecord path parsing from XPath to JSONPath

   - Add JsonPathParser for parsing JSONPath expressions
   - Add backward compatibility for legacy XPath format
   - Update PatchRecord.apply() to use segment-based navigation
   - Fix recordType.getKind() to use kind property instead
   - Ensure both legacy (t, d) and new (recordType) formats are serialized

   BREAKING CHANGE: Server must be using sci_api_model with JSONPath support"
   ```

3. **Tag the release:**
   ```bash
   git tag 1.7.1
   git push origin main --tags
   ```

4. **Update client applications:**
   Update `pubspec.yaml` in client apps:
   ```yaml
   sci_tercen_client:
     git:
       ref: 1.7.1  # Updated version
       url: https://github.com/tercen/sci_tercen_client
       path: sci_tercen_client
   ```

5. **Run pub get:**
   ```bash
   flutter pub get
   ```

## Path Format Examples

### JSONPath Format (NEW - Supported)
- `$.name` - Simple property
- `$.meta` - List property
- `$.steps[0]` - Array index
- `$.steps[?@.id=='abc-123'].name` - Filter by ID
- `$.steps[?@.name=='Step 1'].state.taskState` - Nested filter

### XPath Format (OLD - Still Supported for Backward Compatibility)
- `/name` - Simple property
- `/meta` - List property
- `/steps/@0` - Array index
- `/steps/@[id=abc-123]/name` - Filter by ID

## Troubleshooting

### Error: "Invalid argument: $.meta"
- **Cause:** Client is using old XPath parsing with split('/')
- **Fix:** Update to version with JsonPathParser

### Error: "NoSuchMethodError: getKind()"
- **Cause:** Code is calling `recordType.getKind()` instead of `recordType.kind`
- **Fix:** Change `getKind()` to `kind` property access

### PatchRecords have empty `t` field
- **Cause:** Server removed `t` and `d` fields in toJson(), client can't restore them
- **Fix:** Update toJson() to preserve or restore legacy fields from recordType

### Cannot find step with filter
- **Cause:** Step with that ID doesn't exist in the workflow being patched
- **Fix:** Ensure workflow state is synchronized before applying patches (fetch from server)

## Related Commits

- `0f3b1a3b6` - feat: implement JsonPathParser for path parsing and add backward compatibility for legacy XPath
- `86c60f722` - feat: migrate PatchRecord path formats from XPath to JSONPath
- `f512128f8` - fix: correct JSONPath filter format in meta_factor property handling

## References

- JSONPath Specification: https://goessner.net/articles/JsonPath/
- sci_api_model source: `/home/thiago/workspaces/tercen/main/sci/sci_api_model/`
- Client source: `/home/thiago/workspaces/tercen/main/sci_tercen_client/`
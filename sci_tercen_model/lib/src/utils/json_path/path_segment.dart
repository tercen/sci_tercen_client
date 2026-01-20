import "package:sci_base/sci_base.dart" as base;

abstract class PathSegment {
  dynamic navigate(dynamic target);
}

class RootSegment extends PathSegment {
  @override
  dynamic navigate(dynamic target) => target;
}

class PropertySegment extends PathSegment {
  final String property;
  PropertySegment(this.property);

  @override
  dynamic navigate(dynamic target) {
    if (target is base.Base) {
      return target.get(property);
    }
    throw 'Cannot access property $property on non-Base object';
  }
}

class ArrayIndexSegment extends PathSegment {
  final int index;
  ArrayIndexSegment(this.index);

  @override
  dynamic navigate(dynamic target) {
    if (target is List) {
      return target[index];
    }
    throw 'Cannot index non-list with [$index]';
  }
}

class FilterSegment extends PathSegment {
  final String property;
  final String value;

  FilterSegment(this.property, this.value);

  @override
  dynamic navigate(dynamic target) {
    if (target is! List) {
      throw 'Cannot filter non-list';
    }

    for (var item in target) {
      if (item is base.Base) {
        var propValue = item.get(property);
        if (propValue?.toString() == value) {
          return item;
        }
      }
    }
    throw 'No item found with $property == $value';
  }
}

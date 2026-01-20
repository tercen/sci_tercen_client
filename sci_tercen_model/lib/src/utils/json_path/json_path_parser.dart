import './path_segment.dart';

class JsonPathParser {
  static List<PathSegment> parse(String path) {
    if (path.startsWith(r'$')) {
      return _parseJsonPath(path);
    } else if (path.startsWith('/')) {
      return _parseXPath(path); // Legacy support
    } else {
      throw 'Invalid path format: $path';
    }
  }

  static List<PathSegment> _parseJsonPath(String path) {
    var segments = <PathSegment>[RootSegment()];

    // Remove leading $
    path = path.substring(1);
    if (path.isEmpty) return segments;

    // Regex to match: .property, [0], or [?@.prop=='value']
    var regex = RegExp(r'\.([a-zA-Z_][a-zA-Z0-9_]*)|'
        r'\[(\d+)\]|'
        r'''\[\?@\.([a-zA-Z_][a-zA-Z0-9_]*)==['"]([^'"]+)['"]\]''');

    for (var match in regex.allMatches(path)) {
      if (match.group(1) != null) {
        // Property: .name
        segments.add(PropertySegment(match.group(1)!));
      } else if (match.group(2) != null) {
        // Array index: [0]
        segments.add(ArrayIndexSegment(int.parse(match.group(2)!)));
      } else if (match.group(3) != null && match.group(4) != null) {
        // Filter: [?@.id=='abc']
        segments.add(FilterSegment(match.group(3)!, match.group(4)!));
      }
    }

    return segments;
  }

  static List<PathSegment> _parseXPath(String path) {
    // Legacy XPath parser for backward compatibility
    var segments = <PathSegment>[RootSegment()];
    var parts = path.split('/').skip(1); // Skip empty first element

    for (var part in parts) {
      if (part.isEmpty) continue;

      if (part.startsWith('@[')) {
        // Predicate: @[id=value] or @[name=value]
        var predicateRegex = RegExp(r'@\[([a-zA-Z_]+)=([^\]]+)\]');
        var match = predicateRegex.firstMatch(part);
        if (match != null) {
          segments.add(FilterSegment(match.group(1)!, match.group(2)!));
        }
      } else if (part.startsWith('@')) {
        // Array index: @0
        var index = int.parse(part.substring(1));
        segments.add(ArrayIndexSegment(index));
      } else {
        // Property
        segments.add(PropertySegment(part));
      }
    }

    return segments;
  }
}

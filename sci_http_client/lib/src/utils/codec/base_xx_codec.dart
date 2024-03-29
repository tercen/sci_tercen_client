import 'dart:convert';
import 'dart:math' as math;

/// Alphabet used by base58. Contains all characters used by base64 excluding some that may
/// be misunderstanding (0, O, I, l)
const String base62_characters =
    '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';

abstract class BaseXXEncoder extends Converter<int, String> {
  String get baseChars;

  @override
  String convert(int value) {
    final encoded = StringBuffer();
    final List<String> chars = [];
    int base = baseChars.length;

    do {
      chars.insert(0, baseChars[value % base]);
      value = value ~/ base;
    } while (value > 0);

    encoded.writeAll(chars);
    return encoded.toString();
  }
}

abstract class BaseXXDecoder extends Converter<String, int> {
  String get baseChars;

  @override
  int convert(String value) {
    int decoded = 0;
    final int base = baseChars.length;

    for (int i = value.length - 1; i >= 0; i--) {
      decoded += math.pow(base, value.length - 1 - i) *
          baseChars.indexOf(value[i]) as int;
    }
    return decoded;
  }
}

class Base62Encoder extends BaseXXEncoder {
  static const String BASE_CHARS =
      "`^_-,;:!?.()[]{}@*/&#%+<=>|~\$0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ";

  //static const String BASE_CHARS = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ";
  @override
  String get baseChars => BASE_CHARS;
}

class Base62Decoder extends BaseXXDecoder {
  static const String BASE_CHARS = Base62Encoder.BASE_CHARS;
  @override
  String get baseChars => BASE_CHARS;
}

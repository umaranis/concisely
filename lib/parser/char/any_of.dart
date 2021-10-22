import 'package:concisely/parser/base/char_parser.dart';
import 'package:collection/collection.dart';

/// matches a character if it is one of the given characters
AnyOfParser anyOf(String chars) => AnyOfParser(chars);

class AnyOfParser extends CharBaseParser {
  final List<int> chars;

  AnyOfParser(String chars) : chars = chars.codeUnits;

  @override
  String get label => 'any of';

  @override
  bool verify(int charCode) => chars.contains(charCode);

  @override
  bool hasEqualProperties(AnyOfParser other) {
    return chars.equals(other.chars);
  }

}
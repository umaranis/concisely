import 'package:collection/collection.dart';
import 'package:concisely/src/parser/base/char_parser.dart';

/// matches any character except characters given in [chars] variable
NoneOfParser noneOf(String chars) => NoneOfParser(chars);

class NoneOfParser extends CharBaseParser {
  final List<int> chars;

  NoneOfParser(String chars) : chars = chars.codeUnits;

  @override
  String get name => 'none of';

  @override
  bool verify(int charCode) => !chars.contains(charCode);

  @override
  bool hasEqualProperties(NoneOfParser other) => this.chars.equals(other.chars);

  

}
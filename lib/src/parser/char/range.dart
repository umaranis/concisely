import 'package:concisely/src/parser/base/char_parser.dart';
import 'char.dart';

class CharRangeParser extends CharBaseParser {
  final int startChar, endChar;

  CharRangeParser(String startChar, String endChar) : startChar = toCharCode(startChar), endChar = toCharCode(endChar);

  @override
  String get name => '"${toReadableString(String.fromCharCode(startChar))}-${toReadableString(String.fromCharCode(endChar))}"';

  @override
  bool verify(int charCode) {
    return charCode >= startChar && charCode <= endChar;
  }

  @override
  bool hasEqualProperties(CharRangeParser other) {
    return this.startChar == other.startChar && this.endChar == other.endChar;
  }
  
}
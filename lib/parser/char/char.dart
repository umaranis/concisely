import 'package:concisely/debug/trace.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/base/char_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/char/range.dart';
import 'package:concisely/parser/combiner/choice.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:concisely/parser/transformer/pick_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';

import 'any.dart';

// matches the a character based on the given pattern
// '-' has a special meaning as it specifies character range. If you want to match '-' rather than specifying the range, make sure '-' is the first character in the pattern. For example, char('-+/*) or char('-').
Parser char(String pattern) {
  if(pattern.length == 1) {
    return CharParser(pattern);
  }

  return parse(pattern, charPatternGrammar).value as Parser;
}

Parser get charPatternGrammar {
  var charSingle = any > map((c) => CharParser(c));
  var charRange = any & char('-') & any > pick(0,2).map((r) => CharRangeParser(r[0], r[1]));
  var start = (charRange | charSingle).many > map((r) => ChoiceParser((r as List).cast<Parser>())); // converting List<dynamic> to List<Parser>
  return start;
}

class CharParser extends CharBaseParser{
  final int charCode;  

  CharParser(String char) : charCode = toCharCode(char);

  @override
  String get label => '"${toReadableString(charCode)}"';

  @override
  bool verify(int value) {    
    return value == charCode;
  }
}

/// Converts an object to a character code.
int toCharCode(Object element) {
  if (element is num) {
    return element.round();
  }
  final value = element.toString();
  if (value.length != 1) {
    throw ArgumentError('"$value" is not a character');
  }
  return value.codeUnitAt(0);
}

/// Converts a character or string to a readable string.
String toReadableString(Object element) {
  if (element is String && element.length > 1) {
    final buffer = StringBuffer();
    for (var i = 0; i < element.length; i++) {
      buffer.write(toReadableString(element[i]));
    }
    return buffer.toString();
  }
  final code = toCharCode(element);
  switch (code) {
    case 0x08:
      return '\\b'; // backspace
    case 0x09:
      return '\\t'; // horizontal tab
    case 0x0A:
      return '\\n'; // new line
    case 0x0B:
      return '\\v'; // vertical tab
    case 0x0C:
      return '\\f'; // form feed
    case 0x0D:
      return '\\r'; // carriage return
    case 0x22:
      return '\\"'; // double quote
    case 0x27:
      return "\\'"; // single quote
    case 0x5C:
      return '\\\\'; // backslash
  }
  if (code < 0x20) {
    return '\\x${code.toRadixString(16).padLeft(2, '0')}';
  }
  return String.fromCharCode(code);
}

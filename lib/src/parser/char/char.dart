import 'package:concisely/src/executor.dart';
import 'package:concisely/src/parser/base/char_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/char/range.dart';
import 'package:concisely/src/parser/combiner/choice.dart';
import 'package:concisely/src/parser/combiner/choice_fast.dart';
import 'package:concisely/src/parser/repeater/times.dart';
import 'package:concisely/src/parser/transformer/consume_transformer.dart';
import 'package:concisely/src/parser/transformer/map_transformer.dart';
import 'package:concisely/src/parser/transformer/pick_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';

import 'any.dart';
import 'any_of.dart';

/// matches the a character based on the given pattern
///
/// Examples:
///
///     char('a') - parses 'a'
///     char('ab') - parses character 'a' or 'b'
///     char('a-z') or lowercase - parsers any character from 'a' to 'z'
///     char('A-Z') or uppercase - parses any character from 'A' to 'Z'
///     char('a-zA-z') or letter - parses any alphabet character
///     char('0-9') or digit - parses any character from '0' to '9'
///
/// Note: '-' has a special meaning as it specifies character range. If you want to match '-' rather than specifying the range, make sure '-' is the first character in the pattern. For example, char('-+/*) or char('-').
Parser char(String pattern) {
  if(pattern.length == 1) {
    return CharParser(pattern);
  }
  else if(!pattern.substring(1).contains('-')) {
    return AnyOfParser(pattern);
  }
  else {
    return parse(pattern, charPatternGrammar).value as Parser;
  }
}

Parser get charPatternGrammar {

  // algorithm:
  // 1- Creates two streams of output: regular parsing result and [charArray] variable
  // 2- Any character range goes to regular parsing result as [CharRangeParser] object using map
  // 3- Any individual character goes to [charArray] using consume
  // 4- CharRangeParser list is converted to single object (if list.length is 1) or added to ChoiceParser
  // 5- charArray is converted to CharParser if one character is there or converted to AnyOfParser (using char method)
  // 6- Range parser(s) and character parser are added to ChoiceParser (if both are there)

  var charArray = '';
  var charSingle = any > consume((c) => charArray += c);
  var charRange = any & char('-') & any > pick(0,2).map((r) => CharRangeParser(r[0], r[1]));
  var start = (charRange | charSingle).many > map((r) {
    var l = (r as List).cast<Parser>();  // converting List<dynamic> to List<Parser>
    Parser parser = l.length == 1? l.first : ChoiceFastParser(l); // add range parser or choice of range parsers
    if(charArray.length > 0) {
      if(parser is ChoiceParser) {
        parser.parsers.add(char(charArray));
      }
      else {
        parser = ChoiceFastParser([parser, char(charArray)]);
      }
    }
    return parser;
  });
  return start;
}

class CharParser extends CharBaseParser{
  final int charCode;  

  CharParser(String char) : charCode = toCharCode(char);

  @override
  String get name => '"${toReadableString(charCode)}"';

  @override
  bool verify(int value) {    
    return value == charCode;
  }

  @override
  bool hasEqualProperties(CharParser other) {
    return charCode == other.charCode;
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

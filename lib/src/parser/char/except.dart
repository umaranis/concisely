import 'package:concisely/src/parser/base/char_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/char/none_of.dart';
import 'package:concisely/src/parser/combiner/choice.dart';
import 'package:concisely/src/parser/combiner/choice_fast.dart';
import 'package:concisely/src/parser/repeater/times.dart';
import 'package:concisely/src/parser/transformer/consume_transformer.dart';
import 'package:concisely/src/parser/transformer/map_transformer.dart';
import 'package:concisely/src/parser/transformer/pick_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import '../../executor.dart';
import 'any.dart';
import 'char.dart';

/// parses a character if it doesn't match the given pattern
///
/// Examples:
///     except('a') - parses any character expect 'a'
///     except('ab') or noneOf('ab') - parses any character expect 'a' or 'b'
///     except('a-c') - parses any character except 'a', 'b' and 'c'
///     except('a-c' | newline) - parses any character except 'a', 'b', 'c' and newline
Parser except(String pattern) {
  if(pattern.length == 1) {
    return NotCharParser(pattern);
  }
  else if(!pattern.substring(1).contains('-')) {
    return NoneOfParser(pattern);
  }
  else {
    return parse(pattern, exceptPatternGrammar).value as Parser;
  }
}

Parser get exceptPatternGrammar {

  // algorithm:
  // 1- Creates two streams of output: regular parsing result and [charArray] variable
  // 2- Any character range goes to regular parsing result as [NotCharRangeParser] object using map
  // 3- Any individual character goes to [charArray] using consume
  // 4- NotCharRangeParser list is converted to single object (if list.length is 1) or added to ChoiceParser
  // 5- charArray is converted to NotCharParser if one character is there or converted to NoneOfParser (using except method)
  // 6- Range parser(s) and character parser are added to ChoiceParser (if both are there)

  var charArray = '';
  var charSingle = any > consume((c) => charArray += c);
  var charRange = any & char('-') & any > pick(0,2).map((r) => NotCharRangeParser(r[0], r[1]));
  var start = (charRange | charSingle).many > map((r) {
    var l = (r as List).cast<Parser>();  // converting List<dynamic> to List<Parser>
    Parser parser = l.length == 1? l.first : ChoiceFastParser(l); // add range parser or choice of range parsers
    if(charArray.length > 0) {
      if(parser is ChoiceParser) {
        parser.parsers.add(except(charArray));
      }
      else {
        parser = ChoiceFastParser([parser, except(charArray)]);
      }
    }
    return parser;
  });
  return start;
}


class NotCharParser extends CharBaseParser{
  final int charCode;

  NotCharParser(String char) : charCode = toCharCode(char);

  @override
  String get name => '"except(${toReadableString(charCode)})"';

  @override
  bool verify(int value) {
    return value != charCode;
  }

  @override
  bool hasEqualProperties(NotCharParser other) {
    return charCode == other.charCode;
  }
}

class NotCharRangeParser extends CharBaseParser {
  final int startChar, endChar;

  NotCharRangeParser(String startChar, String endChar) : startChar = toCharCode(startChar), endChar = toCharCode(endChar);

  @override
  String get name => '"except(${toReadableString(String.fromCharCode(startChar))}-${toReadableString(String.fromCharCode(endChar))})"';

  @override
  bool verify(int charCode) {
    return charCode < startChar && charCode > endChar;
  }

  @override
  bool hasEqualProperties(NotCharRangeParser other) {
    return this.startChar == other.startChar && this.endChar == other.endChar;
  }

}
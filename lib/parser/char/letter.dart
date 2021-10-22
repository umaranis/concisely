import 'package:concisely/parser/base/char_parser.dart';

/// matches a character if it is a lower or upper case alphabet (a-z or A-Z)
final LetterParser letter = LetterParser();

class LetterParser extends CharBaseParser {

  @override
  bool verify(int charCode) {    
    return (65 <= charCode && charCode <= 90) || (97 <= charCode && charCode <= 122);
  }

  @override
  String get label => "letter";

  @override
  bool hasEqualProperties(LetterParser other) => true;
    
}



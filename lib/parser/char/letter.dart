import 'package:concisely/parser/base/char_parser.dart';

final LetterParser letter = LetterParser();

class LetterParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return (65 <= charCode && charCode <= 90) || (97 <= charCode && charCode <= 122);
  }

  @override
  String get label => "letter";
    
}


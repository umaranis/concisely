import 'package:concisely/parser/base/char_parser.dart';

final DigitParser digit = DigitParser();

class DigitParser extends CharBaseParser{ 
  
  @override
  bool verify(int charCode) {    
    return 48 <= charCode && charCode <= 57;
  }

  @override
  String get label => "digit";    
    
}


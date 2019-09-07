import 'package:concisely/parser/base/charParser.dart';

final DigitParser digit = DigitParser();

class DigitParser extends CharBaseParser{ 
  
  @override
  bool verify(int charCode) {    
    return 48 <= charCode && charCode <= 57;
  }

  @override
  String getFastParseMessage() {
    return "digit";    
  }

  
}


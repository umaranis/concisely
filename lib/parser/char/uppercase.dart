import 'package:concisely/parser/base/char_parser.dart';

final UppercaseParser uppercase = UppercaseParser();

class UppercaseParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return (65 <= charCode && charCode <= 90);
  }

  @override
  String getFastParseMessage() {
    return "uppercase";    
  }  
}


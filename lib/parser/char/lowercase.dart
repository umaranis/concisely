import 'package:concisely/parser/base/char_parser.dart';

final UppercaseParser lowercase = UppercaseParser();

class UppercaseParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return (97 <= charCode && charCode <= 122);
  }

  @override
  String getFastParseMessage() {
    return "uppercase";    
  }  
}


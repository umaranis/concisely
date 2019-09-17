import 'package:concisely/parser/base/char_parser.dart';

final AnyParser any = AnyParser();

class AnyParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return true;
  }

  @override
  String getFastParseMessage() {
    return "Any character";    
  }  
}


import 'package:concisely/context.dart';
import 'package:concisely/parser/base/char_parser.dart';

final AnyParser any = AnyParser();

class AnyParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return charCode != Context.EOF;
  }

  @override
  String getFastParseMessage() {
    return "Any character";    
  }  
}

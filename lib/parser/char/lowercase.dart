import 'package:conciseparser/parser/base/charParser.dart';

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


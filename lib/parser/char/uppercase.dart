import 'package:conciseparser/parser/base/charParser.dart';

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


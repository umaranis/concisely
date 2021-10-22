import 'package:concisely/parser/base/char_parser.dart';

/// matches a character if it is an upper case alphabet (A-Z)
final UppercaseParser uppercase = UppercaseParser();

class UppercaseParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return (65 <= charCode && charCode <= 90);
  }

  @override
  String get label => "uppercase";

  @override
  bool hasEqualProperties(UppercaseParser other) => true;

  
    
}


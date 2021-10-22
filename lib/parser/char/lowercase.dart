import 'package:concisely/parser/base/char_parser.dart';

/// matches a character if it is a lower case alphabet (a-z)
final LowercaseParser lowercase = LowercaseParser();

class LowercaseParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return (97 <= charCode && charCode <= 122);
  }

  @override
  String get label => 'lowercase';

  @override
  bool hasEqualProperties(LowercaseParser other) => true;
    
}


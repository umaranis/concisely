import 'package:concisely/src/parser/base/char_parser.dart';

/// matches a character if it is 0,1,2,3,4,5,6,7,8 or 9
final DigitParser digit = DigitParser();

class DigitParser extends CharBaseParser{ 
  
  @override
  bool verify(int charCode) {    
    return 48 <= charCode && charCode <= 57;
  }

  @override
  String get name => 'digit';

  @override
  bool hasEqualProperties(DigitParser other) => true;
    
}


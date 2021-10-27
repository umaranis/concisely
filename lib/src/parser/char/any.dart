import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/char_parser.dart';

/// matches any character except end of file
final AnyParser any = AnyParser();

class AnyParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return charCode != Context.EOF;
  }

  @override
  String get name => 'Any character';

  @override
  bool hasEqualProperties(AnyParser other) {
    return this.runtimeType == other.runtimeType;
  }
    
}


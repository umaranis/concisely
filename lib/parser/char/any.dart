import 'package:concisely/context.dart';
import 'package:concisely/parser/base/char_parser.dart';

/// parser a single character matching anything except end of file
final AnyParser any = AnyParser();

class AnyParser extends CharBaseParser{

  @override
  bool verify(int charCode) {    
    return charCode != Context.EOF;
  }

  @override
  String get label => "Any character";
    
}


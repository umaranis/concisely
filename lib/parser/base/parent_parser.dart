import 'package:concisely/parser/base/parser.dart';

/// A parser enclosing a child parser
abstract class ParentParser extends Parser {

  Parser p;

  ParentParser(this.p);

  @override  
  Iterable<Parser> get children => [p];

  @override
  void replace(Parser source, Parser target) { 
    p = target;
  }

}
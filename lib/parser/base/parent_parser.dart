import 'package:concisely/parser/base/parser.dart';

/// A parser enclosing a child parser
abstract class ParentParser extends Parser {

  Parser parser;

  ParentParser(this.parser);

  @override  
  Iterable<Parser> get children => [parser];

  @override
  void replace(Parser source, Parser target) { 
    parser = target;
  }

}
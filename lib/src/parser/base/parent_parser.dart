import 'package:concisely/src/parser/base/parser.dart';

/// A parser enclosing a child parser
abstract class ParentParser<T> extends Parser<T> {

  Parser _parser;

  Parser get parser => _parser;

  ParentParser(this._parser);

  @override  
  Iterable<Parser> get children => [_parser];

  @override
  void replace(Parser source, Parser target) { 
    _parser = target;
  }

}
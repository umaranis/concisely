import 'package:concisely/parser/base/parser.dart';

abstract class TimesParser extends Parser {

  Parser parser;

  TimesParser(this.parser);

  @override  
  Iterable<Parser> get children => [parser];

  @override
  void replace(Parser source, Parser target) { 
    parser = target;
  }

}
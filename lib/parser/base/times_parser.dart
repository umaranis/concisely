import 'package:concisely/parser/base/parser.dart';

abstract class TimesParser extends Parser {
  final Parser parser;

  TimesParser(this.parser);
}
import 'package:concisely/parser/base/parser.dart';

/// Combines of list of parsers to be applied in a sequence
abstract class ListParser extends Parser {
  final List<Parser> parsers;

  ListParser(this.parsers);  

}


import 'package:concisely/parser/base/parser.dart';

/// Contains a list of parsers
abstract class ListParser extends Parser {
  final List<Parser> parsers;

  ListParser(this.parsers);  

  @override
  Iterable<Parser> get children => parsers;

  @override
  void replace(Parser source, Parser target) {
    parsers[parsers.indexOf(source)] = target;
  }

}


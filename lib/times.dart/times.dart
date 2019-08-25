import 'package:conciseparser/times.dart/mutipleTimes.dart';
import 'package:conciseparser/times.dart/optional.dart';
import '../parser.dart';

OptionalParser optional = OptionalParser(null);

Parser timesFactory(Parser parser, Object operand) {
  if(operand is int) {
    return MultipleTimesParser(parser, operand);
  }
  else if(operand is OptionalParser) {
    return OptionalParser(parser);
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}
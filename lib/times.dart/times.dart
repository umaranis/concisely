import 'package:conciseparser/parser/base/fastParser.dart';
import 'package:conciseparser/parser/base/parser.dart';
import 'package:conciseparser/times.dart/mutipleTimes.dart';
import 'package:conciseparser/times.dart/mutipleTimesFast.dart';
import 'package:conciseparser/times.dart/optional.dart';

OptionalParser optional = OptionalParser(null);

Parser timesFactory(Parser parser, Object operand) {
  if(operand is int) {
    return parser is FastParser? MultipleTimesFastParser(parser, operand) : MultipleTimesParser(parser, operand);    
  }
  else if(operand is OptionalParser) {
    return OptionalParser(parser);
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}
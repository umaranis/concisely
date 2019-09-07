import 'package:concisely/parser/base/fastParser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/times.dart/mutipleTimes.dart';
import 'package:concisely/times.dart/mutipleTimesFast.dart';
import 'package:concisely/times.dart/optional.dart';
import 'optionalFast.dart';

OptionalParser optional = OptionalParser(null);

Parser timesFactory(Parser parser, Object operand) {
  if(operand is int) {
    return parser is FastParser? MultipleTimesFastParser(parser, operand) : MultipleTimesParser(parser, operand);    
  }
  else if(operand is OptionalParser) {
    return parser is FastParser? OptionalFastParser(parser) : OptionalParser(parser);
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}
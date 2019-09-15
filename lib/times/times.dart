import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/times/mutiple_times.dart';
import 'package:concisely/times/mutiple_times_fast.dart';
import 'package:concisely/times/optional.dart';
import 'optional_fast.dart';

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
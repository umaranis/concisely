import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/times/many.dart';
import 'package:concisely/times/mutiple_times.dart';
import 'package:concisely/times/mutiple_times_fast.dart';
import 'package:concisely/times/optional.dart';
import 'optional_fast.dart';

final OptionalParser optional = OptionalParser(null);
final ManyParser many = ManyParser(null);

Parser timesFactory(Parser parser, Object operand) {
  if(operand is int) {
    return parser is FastParser? MultipleTimesFastParser(parser, operand) : MultipleTimesParser(parser, operand);    
  }
  else if(operand == optional) {
    return parser is FastParser? OptionalFastParser(parser) : OptionalParser(parser);
  }
  else if(operand == many) {
    return ManyParser(parser);
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}
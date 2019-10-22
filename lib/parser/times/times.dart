import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'many.dart';
import 'many_fast.dart';
import 'mutiple_times.dart';
import 'mutiple_times_fast.dart';
import 'optional.dart';
import 'optional_fast.dart';

final OptionalParser optional = OptionalParser(null);
/// Repeats the given parser one or more times.
/// Also called 'plus (+)' or '1+' in some parsing systems.
final ManyParser many = ManyParser(null);

Parser timesFactory(Parser parser, Object operand) {
  if(operand is int) {
    return parser is FastParser? MultipleTimesFastParser(parser, operand) : MultipleTimesParser(parser, operand);    
  }
  else if(operand == optional) {
    return parser is FastParser? OptionalFastParser(parser) : OptionalParser(parser);
  }
  else if(operand == many) {
    return parser is FastParser? ManyFastParser(parser) : ManyParser(parser);
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}
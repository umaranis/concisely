import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/times/between_times.dart';
import 'package:concisely/parser/times/min_times.dart';
import 'package:concisely/parser/times/min_times_fast.dart';
import 'package:concisely/parser/times/zero_or_more.dart';
import 'package:concisely/parser/times/zero_or_more_fast.dart';
import 'between_times_fast.dart';
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
MinTimesParser min(int min) {
  return MinTimesParser(null, min);
}
BetweenTimesParser between(int min, int max) {
  return BetweenTimesParser(null, min, max);
}

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
  else if(operand is MinTimesParser) {
    if(parser is FastParser) {
      return MinTimesFastParser(parser, operand.min);
    } else {
      operand.p = parser;
      return operand;
    }
  }
  else if(operand is BetweenTimesParser) {
    if(parser is FastParser) {
      return BetweenTimesFastParser(parser, operand.min, operand.max);
    }
    else {
      operand.p = parser;
      return operand;
    }
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}

extension TimesParser on Parser {

  Parser times(int times, {int max = 0}) {
    if(max == 0) {
      return this is FastParser? MultipleTimesFastParser(this, times) : MultipleTimesParser(this, times);
    }
    else {
      return this is FastParser? BetweenTimesFastParser(this, times, max) : BetweenTimesParser(this, times, max);
    }
  }

  Parser minTimes(int min) {
    return this is FastParser? MinTimesFastParser(this, min) : MinTimesParser(this, min);
  }

  Parser get many => this is FastParser? ManyFastParser(this) : ManyParser(this);

  Parser get optional => this is FastParser? OptionalFastParser(this) : OptionalParser(this);

  Parser get zeroOrMore => this is FastParser? ZeroOrMoreFastParser(this) : ZeroOrMoreParser(this);
}

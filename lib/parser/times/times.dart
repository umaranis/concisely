import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/times/between_times.dart';
import 'package:concisely/parser/times/min_times.dart';
import 'package:concisely/parser/times/min_times_fast.dart';
import 'package:concisely/parser/times/zero_or_more.dart';
import 'between_times_fast.dart';
import 'many.dart';
import 'many_fast.dart';
import 'multiple_times.dart';
import 'multiple_times_fast.dart';
import 'optional.dart';
import 'optional_fast.dart';

enum TimesParameterType { Optional, Many, Min, Between }

class TimesParameter {
  final TimesParameterType type;
  final int min;
  final int max;


  const TimesParameter(this.type, this.min, this.max);
}

final optional = TimesParameter(TimesParameterType.Optional, -1, -1);

/// Repeats the given parser one or more times.
/// Also called 'plus (+)' or '1+' in some parsing systems.
final many = TimesParameter(TimesParameterType.Many, -1, -1);

TimesParameter min(int min) {
  return TimesParameter(TimesParameterType.Min, min, -1);
}

TimesParameter between(int min, int max) {
  return TimesParameter(TimesParameterType.Between, min, max);
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
  else if((operand as TimesParameter).type == TimesParameterType.Min) {
    if(parser is FastParser) {
      return MinTimesFastParser(parser, operand.min);
    } else {
      return MinTimesParser(parser, operand.min);
    }
  }
  else if(operand.type == TimesParameterType.Between) {
    if(parser is FastParser) {
      return BetweenTimesFastParser(parser, operand.min, operand.max);
    }
    else {
      return BetweenTimesParser(parser, operand.min, operand.max);
    }
  }

  throw ArgumentError("Wrong arguments to Parser '*' operator.");
}

extension TimesParser on Parser {

  Parser times(int times, {int max = 0}) {
    if(max == 0) {
      return this is FastParser? MultipleTimesFastParser(this as FastParser, times) : MultipleTimesParser(this, times);
    }
    else {
      return this is FastParser? BetweenTimesFastParser(this as FastParser, times, max) : BetweenTimesParser(this, times, max);
    }
  }

  Parser minTimes(int min) {
    return this is FastParser? MinTimesFastParser(this as FastParser, min) : MinTimesParser(this, min);
  }

  Parser get many => this is FastParser? ManyFastParser(this as FastParser) : ManyParser(this);

  Parser get optional => this is FastParser? OptionalFastParser(this as FastParser) : OptionalParser(this);

  /// Repeats the given parser zero or more times.
  /// Also called 'star (*)' or '0+' in some parsing systems.
  /// Returns results in an array by default.
  /// Parsing 'abc' with `letter.zeroOrMore` will return ['a','b','c']
  /// Parsing '123' with `letter.zeroOrMore` will return []
  Parser get zeroOrMore => this is FastParser? ZeroOrMoreFastParser(this as FastParser) : ZeroOrMoreParser(this);
}

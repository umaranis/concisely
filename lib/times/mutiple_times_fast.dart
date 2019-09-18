import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/times/mutiple_times.dart';

class MultipleTimesFastParser extends TimesFastParser {
  final FastParser parser;
  final int times;

  MultipleTimesFastParser(this.parser, this.times);

  @override
  int fastParse(Context context, int offset) {    
    int result = offset;
    for(int i = 0; i < times; i++) {
      result = parser.fastParse(context, result);
      if(result == -1) {        
        return -1;
      }

    }  
    return result;     
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * " + times.toString() + " times";
  }

  @override
  Parser getFallbackParser() {    
    return MultipleTimesParser(parser, times);
  }

}
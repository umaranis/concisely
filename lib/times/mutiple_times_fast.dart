import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';
import 'package:concisely/times/mutiple_times.dart';

class MultipleTimesFastParser extends FastParser {
  final FastParser parser;
  final int times;

  MultipleTimesFastParser(this.parser, this.times);

  @override
  Result parse(Context context) {    
    final result = fastParse(context, context.pos);    
    if(result == -1) {
      return MultipleTimesParser(parser, times).parse(context);
    }   
    
    return Success(context.moveTo(result), getFastParseResult(context, context.pos, result));
  }

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
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return context.subStringFromOffset(startPosition, endPosition);
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * " + times.toString() + " times";
  }

}
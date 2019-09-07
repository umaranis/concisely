import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fastParser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';
import 'package:concisely/times.dart/mutipleTimes.dart';

class MultipleTimesFastParser extends FastParser {
  final FastParser parser;
  final int times;

  MultipleTimesFastParser(this.parser, this.times);

  @override
  Result parse(Context context) {    
    final result = fastParse(context, 0);    
    if(result == -1) {
      return MultipleTimesParser(parser, times).parse(context);
    }   

    // TODO: Seems like a bug, why move by times, probably wrong assumption that each parse is of 1 char
    return Success(context.move(times), getFastParseResult(context, 0, times));
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

  // TODO: Probably has a bug, doesn't make sense to added initialOffset and resultPosition
  @override
  String getFastParseResult(Context context, int initialOffset, int resultPosition) {
    return context.substring(initialOffset + resultPosition);
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * " + times.toString() + " times";
  }

}
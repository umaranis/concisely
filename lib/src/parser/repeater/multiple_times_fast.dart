import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/times_fast_parser.dart';
import 'multiple_times.dart';

class MultipleTimesFastParser extends MultipleTimesParser with FastParser, DefaultFastParseResult, ParentFastParser, IntrusiveFastParser {
  
  MultipleTimesFastParser(FastParser parser, int times) : super(parser, times);

  @override
  int fastParse(Context context, int offset) {    
    int result = offset;
    for(int i = 0; i < times; i++) {
      result = fastParser.fastParse(context, result);
      if(result == -1) {        
        return -1;
      }

    }  
    return result;     
  }

}
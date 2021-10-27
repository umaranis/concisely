import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/times_fast_parser.dart';

import 'between_times.dart';

class BetweenTimesFastParser extends BetweenTimesParser with FastParser, DefaultFastParseResult, ParentFastParser, IntrusiveFastParser {

  BetweenTimesFastParser(FastParser parser, int min, int max) : super(parser, min, max);
  
  @override
  int fastParse(Context context, int position) {    
    
    int result, index = 0;
    for(; index < min; index++) {
      result = fastParser.fastParse(context, position);
      if (result != -1) {
        position = result;
      }
      else {
        return -1;
      }
    }

    for(; index < max; index++) {
      result = fastParser.fastParse(context, position);
      if(result != -1) {
        position = result;
      }
      else {        
        return position;
      }
    }

    return position;
  }  

}
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'many.dart';

class ManyFastParser extends ManyParser with FastParser, DefaultFastParseResult, TimesFastParser, IntrusiveFastParser {  

  ManyFastParser(FastParser parser) : super(parser);
  
  @override
  int fastParse(Context context, int position) {    
    
    int result = fastParser.fastParse(context, position);
    if(result != -1) {
      position = result;
    }
    else {      
      return -1;
    }
    
    while(true) {
      result = fastParser.fastParse(context, position);
      if(result != -1) {
        position = result;
      }
      else {        
        return position;
      }
    }   
  }

}
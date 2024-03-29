import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/times_fast_parser.dart';
import 'many.dart';

class ManyFastParser extends ManyParser with FastParser, DefaultFastParseResult, ParentFastParser, IntrusiveFastParser {

  ManyFastParser(FastParser parser) : super(parser);
  
  @override
  int fastParse(Context context, int position) {    
    
    var result = fastParser.fastParse(context, position);
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
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/parser/times/zero_or_more.dart';

class ZeroOrMoreFastParser extends ZeroOrMoreParser with FastParser, DefaultFastParseResult, ParentFastParser, IntrusiveFastParser {

  ZeroOrMoreFastParser(FastParser parser) : super(parser);
  
  @override
  int fastParse(Context context, int position) {    
    
    int result;
    
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
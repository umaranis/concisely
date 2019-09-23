import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'many.dart';

class ManyFastParser extends TimesFastParser {  

  ManyFastParser(FastParser parser) : super(parser);
  
  @override
  int fastParse(Context context, int position) {    
    
    int result = parser.fastParse(context, position);
    if(result != -1) {
      position = result;
    }
    else {      
      return -1;
    }
    
    while(true) {
      result = parser.fastParse(context, position);
      if(result != -1) {
        position = result;
      }
      else {        
        return position;
      }
    }   
  }  

  @override
  String get label => parser.label + " * many times";

  @override
  Parser getFallbackParser() {    
    return ManyParser(parser);
  }

}
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';
import 'many.dart';

class ManyFastParser extends FastParser {
  final FastParser parser;

  ManyFastParser(this.parser);

  @override
  Result parse(Context context) {    
    final result = fastParse(context, context.pos);    
    if(result == -1) {
      return ManyParser(parser).parse(context);
    }   
    
    return Success(context.moveTo(result), getFastParseResult(context, context.pos, result));
  }

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
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return context.subStringFromOffset(startPosition, endPosition);
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * many times";
  }

}
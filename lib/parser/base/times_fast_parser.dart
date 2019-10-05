import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

abstract class TimesFastParser extends FastParser {
  FastParser parser;

  TimesFastParser(this.parser);
  
  Parser getFallbackParser();

  @override
  Result parse(Context context) {    
    final result = fastParse(context, context.pos);    
    if(result == -1) {
      return getFallbackParser().parse(context);
    }   
    
    return Success(context.moveTo(result), getFastParseResult(context, context.pos, result));
  }

  @override
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return context.subStringFromOffset(startPosition, endPosition);
  }

  @override  
  Iterable<Parser> get children => [parser];

  @override
  void replace(Parser source, Parser target) { 
    parser = target;
  }

}
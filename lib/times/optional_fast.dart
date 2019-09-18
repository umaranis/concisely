import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';
import 'package:concisely/times/optional.dart';

class OptionalFastParser extends FastParser {
  final FastParser parser;

  OptionalFastParser(this.parser);

  @override
  Result parse(Context context) {    
    final result = fastParse(context, context.pos);    
    if(result == -1) {
      return OptionalParser(parser).parse(context);
    }   

    return Success(context.moveTo(result), getFastParseResult(context, context.pos, result));
  }

  @override
  int fastParse(Context context, int position) {    
    final result = parser.fastParse(context, position);
    return result == -1? position : result;
  }

  @override
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return context.subStringFromOffset(startPosition, endPosition);
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * optional";
  }

}
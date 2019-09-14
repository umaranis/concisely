import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fastParser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';
import 'package:concisely/times/optional.dart';

class OptionalFastParser extends FastParser {
  final FastParser parser;

  OptionalFastParser(this.parser);

  @override
  Result parse(Context context) {    
    final result = fastParse(context, 0);    
    if(result == -1) {
      return OptionalParser(parser).parse(context);
    }   

    return Success(context.move(result), getFastParseResult(context, 0, result));
  }

  @override
  int fastParse(Context context, int offset) {    
    final result = parser.fastParse(context, offset);
    return result == -1? offset : result;
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
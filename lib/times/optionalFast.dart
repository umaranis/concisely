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

  // TODO: Probably has a bug, doesn't make sense to added initialOffset and resultPosition
  @override
  String getFastParseResult(Context context, int initialOffset, int length) {
    return context.subStringFromOffset(initialOffset, length);
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * optional";
  }

}
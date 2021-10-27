import 'package:concisely/src/context.dart';
import 'package:concisely/src/debug/callbacks.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

class WrapperParser extends Parser with FastParser {
  final Parser parser;
  final Callbacks callbacks;

  WrapperParser(this.parser, this.callbacks);  

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {    
    callbacks.preParse(PreParseContext(parser, context));
    final result = parser.parse(context, outputType);
    callbacks.postParse(PostParseContext(parser, context, result));
    return result;
  }

  @override  
  String get name => parser.name;

  @override
  int fastParse(Context context, int pos) {
    callbacks.preFastParse(PreFastParseContext(parser, context, pos));
    int result = (parser as FastParser).fastParse(context, pos);
    callbacks.postFastParse(PostFastParseContext(parser, context, pos, result));
    return result;
  }

  @override
  getFastParseResult(Context context, int startPosition, int endPosition) {    
    return (parser as FastParser).getFastParseResult(context, startPosition, endPosition);
  }

  @override
  bool hasEqualProperties(WrapperParser other) {
    return this.callbacks.preParse == other.callbacks.preParse
        && this.callbacks.preFastParse == other.callbacks.preFastParse
        && this.callbacks.postParse == other.callbacks.postParse
        && this.callbacks.postFastParse == other.callbacks.postFastParse;
  }
  
}
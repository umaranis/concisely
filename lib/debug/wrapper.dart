import 'package:concisely/context.dart';
import 'package:concisely/debug/callbacks.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/result/result.dart';

class WrapperParser extends FastParser {
  final Parser parser;
  final Callbacks callbacks;

  WrapperParser(this.parser, this.callbacks);  

  @override
  Result parse(Context context) {    
    callbacks.preParse(PreParseContext(parser, context));
    final result = parser.parse(context);
    callbacks.postParse(PostParseContext(parser, context, result));
    return result;
  }

  @override  
  String get label => parser.label;

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
  
}
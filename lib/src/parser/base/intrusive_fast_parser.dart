import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// Tries to fast parse even for the regular parse call.
/// It switches from slowing parsing to fast parsing when a fast parser is encountered at:
/// - start of parsing
/// - as a child of slow parser
///
/// The logic of this mixin should be implemented by all fast parsers
mixin IntrusiveFastParser<T> on FastParser<T> {

  @override
  Result<T> parse(Context context, [OutputType outputType = OutputType.tree]) {
    if(outputType != OutputType.string) { //TODO: this looks wrong... if its a fast parser why go always go for fastParse metthod
      return super.parse(context, outputType);
    }
    else {
      final result = fastParse(context, context.pos);    
      if(result == -1) {
        return super.parse(context, outputType);
      }   
      
      return Success(context.moveTo(result), getFastParseResult(context, context.pos, result) as T);
    }
  }

}
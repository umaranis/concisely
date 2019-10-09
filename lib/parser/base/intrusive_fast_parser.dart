import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

/// Tries to fast parse even for the regular parse call
mixin IntrusiveFastParser on FastParser {

  @override
  Result parse(Context context, [OutputType outputType]) {
    if(outputType != OutputType.string) {
      return super.parse(context, outputType);
    }
    else {
      final result = fastParse(context, context.pos);    
      if(result == -1) {
        return super.parse(context, outputType);
      }   
      
      return Success(context.moveTo(result), getFastParseResult(context, context.pos, result));
    }
  }

}
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';
import 'fast_parser.dart';
import 'parser.dart';

abstract class CharBaseParser extends Parser<String> with FastParser {

  @override
  Result<String> parse(Context context, [OutputType outputType = OutputType.tree]) {
    var value = context.seek();
    if (verify(value)) {
      return Success(context.move(1), String.fromCharCode(value));
    }
    return Failure<String>(context, name + ' expected');
  }
  
  @override
  int fastParse(Context context, int position) {
    var value = context.seekAt(position);
    if (verify(value)) {
      return position + 1;
    }    
    return -1;    
  }

  @override
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return String.fromCharCode(context.seek(startPosition));
  }

  bool verify(int charCode);
}
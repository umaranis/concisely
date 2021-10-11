import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

abstract class CharBaseParser extends Parser with FastParser{

  @override
  Result<String> parse(Context context, [OutputType outputType]) {
    var value = context.seek();
    if (verify(value)) {
      return Success(context.move(1), String.fromCharCode(value));
    }
    return Failure(context, label + ' expected');
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
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// matches with end of input
final EOFParser eof = EOFParser();

/// Parses End of File.
/// It is different from other character parsers in the sense that it doesn't consume any input, produce a value or move the context forward.
class EOFParser extends Parser with FastParser {
  
  @override
  Result<Object?> parse(Context context, [OutputType outputType = OutputType.tree]) {
    int value = context.seek();
    if (verify(value)) {
      return Success(context, blank);
    }
    return Failure(context, name + ' expected');
  }
  
  @override
  int fastParse(Context context, int offset) {
    int value = context.seek(offset);
    if (verify(value)) {
      return offset;
    }    
    return -1;    
  }

  @override
  String? getFastParseResult(Context context, int startPosition, int endPosition) {
    return null;
  }
  
  bool verify(int value) {
    return value == Context.EOF;
  }

  @override
  String get name => 'End of File';

  @override
  bool hasEqualProperties(EOFParser other) => true;

}
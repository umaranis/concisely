import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

final EOFParser eof = EOFParser();

/// Parses End of File.
/// It is different from other character parsers in the sense that it doesn't consume any input, produce a value or move the context forward.
class EOFParser extends FastParser {
  
  @override
  Result<String> parse(Context context) {
    int value = context.seek();
    if (verify(value)) {
      return Success(context, null);
    }
    return Failure(context, label + ' expected');
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
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return null;
  }
  
  bool verify(int value) {
    return value == Context.EOF;
  }

  @override
  String get label => 'End of File';

}
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/char/char.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

Parser str(String text) {
  return text.length == 1? char(text) : StringParser(text);
}

class StringParser extends Parser with FastParser {
  final String text;

  StringParser(this.text);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    for(int i = 0; i < text.length; i++) {
      if(context.seek(i) != text.codeUnitAt(i)) {
        return Failure(context, '"$text" expected');
      }
    }
    return Success(context.move(text.length), text);
}

  @override
  int fastParse(Context context, int position) {
    for(int i = 0; i < text.length; i++) {
      if(context.seekAt(position + i) != text.codeUnitAt(i)) {
        return -1;
      }
    }
    return position + text.length;
  }

  @override
  getFastParseResult(Context context, int startPosition, int endPosition) {
    return text;
  }

  @override
  String get name => '"${toReadableString(text)}"';

  @override
  bool hasEqualProperties(StringParser other) => this.text == other.text;

}
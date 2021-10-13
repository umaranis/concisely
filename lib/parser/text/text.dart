import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

TextParser text(String text) {
  return TextParser(text);
}

class TextParser extends Parser with FastParser {
  final String text;

  TextParser(this.text);

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
  String get label => '"${toReadableString(text)}"';

}
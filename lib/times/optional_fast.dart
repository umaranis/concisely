import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';
import 'package:concisely/times/optional.dart';

class OptionalFastParser extends TimesFastParser {
  final FastParser parser;

  OptionalFastParser(this.parser);

  @override
  int fastParse(Context context, int position) {    
    final result = parser.fastParse(context, position);
    return result == -1? position : result;
  }

  @override
  String getFastParseMessage() {    
    return parser.getFastParseMessage() + " * optional";
  }

  @override
  Parser getFallbackParser() {    
    return OptionalParser(parser);
  }

}
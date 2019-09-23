import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/times/optional.dart';

class OptionalFastParser extends TimesFastParser {  

  OptionalFastParser(FastParser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {    
    final result = parser.fastParse(context, position);
    return result == -1? position : result;
  }

  @override
  String get label => '${parser.label} optional';

  @override
  Parser getFallbackParser() {    
    return OptionalParser(parser);
  }

}
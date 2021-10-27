import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/combiner/choice.dart';

class ChoiceFastParser extends ChoiceParser  with FastParser, DefaultFastParseResult, IntrusiveFastParser {
  ChoiceFastParser(List<Parser> parsers) : super(parsers);

  @override
  int fastParse(Context context, int position) {
    for (var p in parsers) {
      final fp = p as FastParser; 
      final r = fp.fastParse(context, position);
      if(r != -1) {
        return r;
      }         
    }

    return -1;
  }

  @override
  Parser operator | (Parser other) {
    parsers.add(other);
    return other is FastParser? this : ChoiceParser(parsers);
  }
  
}
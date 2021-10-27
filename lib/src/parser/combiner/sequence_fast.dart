import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/combiner/sequence.dart';

class SequenceFastParser extends SequenceParser with FastParser, DefaultFastParseResult, IntrusiveFastParser {
  SequenceFastParser(List<Parser> parsers) : super(parsers);

  
  @override
  int fastParse(Context context, int position) {
    for (var p in parsers) {
      final fp = p as FastParser;
      position = fp.fastParse(context, position);
      if(position == -1) {
        return -1;
      }      
    }
    return position;
  }

  @override
  SequenceParser operator & (Parser other) {
    parsers.add(other);
    return other is FastParser? this : SequenceParser(parsers);
  }

}
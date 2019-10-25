import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'optional.dart';

class OptionalFastParser extends OptionalParser with FastParser, DefaultFastParseResult, TimesFastParser, IntrusiveFastParser {  

  OptionalFastParser(FastParser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {    
    final result = fastParser.fastParse(context, position);
    return result == -1? position : result;
  }

}
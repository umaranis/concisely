import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

/// Repeats the given parser zero or more times.
/// Also called 'star (*)' or '0+' in some parsing systems.
class ZeroOrMoreParser extends ParentParser {

  ZeroOrMoreParser(Parser parser) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {    
    final combiner = getCombiner(outputType);
    var current = context;
    
    var result;
    
    while(true) {
      result = p.parse(current, outputType);
      if(result.isSuccess) {
        combiner.append(result.value);
        current = result.context;
      }
      else {
        Object? result = isEmptyList(combiner.result) ? null : combiner.result;
        return Success(current, result);
      }
    }
  }

  @override
  String get label => p.label + ' * 0 or more times';

}



class ZeroOrMoreFastParser extends ZeroOrMoreParser with FastParser, DefaultFastParseResult, ParentFastParser, IntrusiveFastParser {

  ZeroOrMoreFastParser(FastParser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {

    int result;

    while(true) {
      result = fastParser.fastParse(context, position);
      if(result != -1) {
        position = result;
      }
      else {
        return position;
      }
    }
  }

}

bool isEmptyList(Object? result) {
  return result is List && result.isEmpty;
}
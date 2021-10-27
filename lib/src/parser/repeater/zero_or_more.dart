import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/times_fast_parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

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
      result = parser.parse(current, outputType);
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
  String get name => parser.name + ' * 0 or more times';

  @override
  bool hasEqualProperties(ZeroOrMoreParser other) => true;

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
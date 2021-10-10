import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

/// Repeats the given parser zero or more times.
/// Also called 'star (*)' or '0+' in some parsing systems.
class ZeroOrMoreParser extends ParentParser {

  ZeroOrMoreParser(Parser parser) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType]) {    
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
        return Success(current, combiner.result);
      }
    }
  }

  @override
  String get label => p.label + ' * 0 or more times';

}
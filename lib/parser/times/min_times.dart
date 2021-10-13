import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

/// Repeats the given parser [min] or more times.
/// e.g. letter * min(5) // match 5 or more letters
class MinTimesParser extends ParentParser {
  /// minimum number of times the parser is repeated
  final int min;
  MinTimesParser(Parser parser, this.min) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {    
    final combiner = getCombiner(outputType);
    var current = context;
    
    var result;
    for(int i = 0; i < min; i++) {
      result = p.parse(current, outputType);
      if (result.isSuccess) {
        combiner.append(result.value);
        current = result.context;
      }
      else {
        return Failure(current, result.message);
      }
    }
    
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
  String get label => p.label + " * " + min.toString() + " times or more";

}
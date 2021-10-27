import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

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
      result = parser.parse(current, outputType);
      if (result.isSuccess) {
        combiner.append(result.value);
        current = result.context;
      }
      else {
        return Failure(current, result.message);
      }
    }
    
    while(true) {
      result = parser.parse(current, outputType);
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
  String get name => parser.name + " * " + min.toString() + " times or more";

  @override
  bool hasEqualProperties(MinTimesParser other) => this.min == other.min;

}
import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

/// Repeats the given parser between [min] to [max] times.
/// For exmaple:
/// digit * between(5,10) // match 5 to 10 digits (5,10 inclusive)
///  '1234'             -> Fail                   // fails to parse as minimum 5 is required
///  '12345'            -> [1,2,3,4,5]            // success
///  '12345678901234'   -> [1,2,3,4,5,6,7,8,9,0]  // first 10 digits are parsed
class BetweenTimesParser extends ParentParser {
  /// minimum number of times the parser is repeated
  final int min, max;
  BetweenTimesParser(Parser parser, this.min, this.max) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    final combiner = getCombiner(outputType);
    var current = context;

    var result;
    var index = 0;
    for(; index < min; index++) {
      result = parser.parse(current, outputType);
      if (result.isSuccess) {
        combiner.append(result.value);
        current = result.context;
      }
      else {
        return Failure(current, result.message);
      }
    }

    for(; index < max; index++) {
      result = parser.parse(current, outputType);
      if(result.isSuccess) {
        combiner.append(result.value);
        current = result.context;
      }
      else {
        return Success(current, combiner.result);
      }
    }

    return Success(current, combiner.result);
  }

  @override
  String get name => parser.name + ' * ' + min.toString() + ' to ' + max.toString() + ' times';

  @override
  bool hasEqualProperties(BetweenTimesParser other) => this.min == other.min && this.max == other.max;

}
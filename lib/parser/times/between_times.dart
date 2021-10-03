import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

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
  Result parse(Context context, [OutputType outputType]) {
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
  String get label => parser.label + ' * ' + min.toString() + ' to ' + max.toString() + ' times';

}
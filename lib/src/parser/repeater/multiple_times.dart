import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

class MultipleTimesParser extends ParentParser {  
  final int times;

  MultipleTimesParser(Parser parser, this.times) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {    
    final combiner = getCombiner(outputType);
    var current = context;
    for(int i = 0; i < times; i++) {
      var result = parser.parse(current, outputType);
      if(result.isSuccess) {
        combiner.append(result.value);
        current = result.context;
      }
      else {
        return Failure(current, result.message!); // result.message can't be null for Failure
      }
    }   

    return Success(current, combiner.result);
  }

  @override
  String get name => '${parser.name} * ${times} times';

  @override
  bool hasEqualProperties(MultipleTimesParser other) => this.times == other.times;

}
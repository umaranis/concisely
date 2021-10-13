import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

class MultipleTimesParser extends ParentParser {  
  final int times;

  MultipleTimesParser(Parser parser, this.times) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {    
    final combiner = getCombiner(outputType);
    var current = context;
    for(int i = 0; i < times; i++) {
      var result = p.parse(current, outputType);
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
  String get label => '${p.label} * ${times} times';

}
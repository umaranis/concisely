import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

/// Repeats the given parser one or more times.
/// Also called 'plus (+)' or '1+' in some parsing systems.
class ManyParser extends ParentParser {    

  ManyParser(Parser parser) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType]) {    
    final combiner = getCombiner(outputType);
    var current = context;
    
    var result = parser.parse(current, outputType);
    if(result.isSuccess) {
      combiner.append(result.value);
      current = result.context;
    }
    else {
      return Failure(current, result.message);
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
  String get label => parser.label + " * many";

}
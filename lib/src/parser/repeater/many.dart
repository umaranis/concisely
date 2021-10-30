import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

/// Repeats the given parser one or more times.
/// Also called 'plus (+)' or '1+' in some parsing systems.
class ManyParser extends ParentParser {    

  ManyParser(Parser parser) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {    
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
  String get name => parser.name + ' * many times';

  @override
  bool hasEqualProperties(ManyParser other) => true;

}
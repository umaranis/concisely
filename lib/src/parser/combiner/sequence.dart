import 'package:concisely/src/parser/base/list_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

/// Combines of list of parsers to be applied in a sequence
class SequenceParser extends ListParser {

  SequenceParser(List<Parser> parsers) : super(parsers);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    final combiner = getCombiner(outputType);    
    var currentResult;
    for (var parser in parsers) {
      currentResult = parser.parse(context, outputType);
      if(currentResult.isFailure) {
        return currentResult;
      }
      else {
        context = currentResult.context;
        combiner.append(currentResult.value);
      }
    }

    return Success(currentResult.context, combiner.result);
  }      

  @override
  String get name => 'Sequence';

  @override
  SequenceParser operator & (Parser other) {
    parsers.add(other);
    return this;
  }

  @override
  bool hasEqualProperties(SequenceParser other) => true;
  
}


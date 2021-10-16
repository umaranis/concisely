import 'package:concisely/parser/base/list_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/parser/transformer/skip_transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';
import 'package:concisely/result/success.dart';

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
        if(currentResult.value != blank) {
          combiner.append(currentResult.value);
        }
      }
    }

    return Success(currentResult.context, combiner.result);
  }      

  @override
  String get label => 'Sequence';

  @override
  SequenceParser operator & (Parser other) {
    parsers.add(other);
    return this;
  } 
  
}


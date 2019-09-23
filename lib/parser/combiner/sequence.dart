import 'package:concisely/parser/base/list_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

/// Combines of list of parsers to be applied in a sequence
class SequenceParser extends ListParser {

  SequenceParser(List<Parser> parsers) : super(parsers);

  @override
  Result parse(Context context) {

    var resultList = [];
    var currentResult;
    for (var parser in parsers) {
      currentResult = parser.parse(context);
      if(currentResult.isFailure) {
        return currentResult;
      }
      else {
        context = currentResult.context;
        if(currentResult.value != null) {
          resultList.add(currentResult.value);
        }
      }
    }

    return Success(currentResult.context, resultList);    
  }

  @override
  String get label => "Sequence";

  @override
  Parser operator & (Parser other) {
    parsers.add(other);
    return this;
  } 
  
}


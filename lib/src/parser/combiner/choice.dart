import 'package:concisely/src/parser/base/list_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

/// Evaluates a list of parsers till one of them is successful.
/// If none of the parsers is successful, then returns the last failure
class ChoiceParser extends ListParser {
  
  ChoiceParser(List<Parser> parsers) : super(parsers);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {

    var r;
    for (var p in parsers) {
      r = p.parse(context, outputType);
      if(r.isSuccess) {
        return r;
      }         
    }

    return r;
  }

  @override
  String get name {
    return parsers.map((p) => p.name).reduce((p1, p2) => '$p1 or $p2');
  }

  @override
  Parser operator | (Parser other) {
    parsers.add(other);
    return this;
  }

  @override
  bool hasEqualProperties(ChoiceParser other) => true;

}


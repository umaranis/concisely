import 'package:concisely/parser/base/list_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

class ChoiceParser extends ListParser {
  
  ChoiceParser(List<Parser> parsers) : super(parsers);

  @override
  Result parse(Context context, [OutputType outputType]) {

    for (var p in parsers) {
      var r = p.parse(context, outputType);
      if(r.isSuccess) {
        return r;
      }         
    }

    return Failure(context, '$label expected');
  }

  @override
  String get label {
    return parsers.map((p) => p.label).reduce((p1, p2) => '$p1 or $p2');    
  }

  @override
  Parser operator | (Parser other) {
    parsers.add(other);
    return this;
  } 

}


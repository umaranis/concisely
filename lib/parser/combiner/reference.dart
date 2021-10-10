import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

class ParserReference extends ParentParser {
  ParserReference() : super(null);

  @override
  String get label => 'Parser reference';

  @override
  Result parse(Context context, [OutputType outputType]) {
    return p.parse(context, outputType);
  }

}

/// Reference to a parser
ParserReference ref() {
  return ParserReference();
}
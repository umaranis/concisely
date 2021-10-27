import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

class ParserReference extends ParentParser {
  ParserReference(Parser parser): super(parser);

  Parser get p => this.parser;
  void set p(Parser parser) => replace(this.parser, parser);

  @override
  String get name => 'Parser reference';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return parser.parse(context, outputType);
  }

  @override
  bool hasEqualProperties(ParserReference other) => true;
}

/// Reference to a parser
ParserReference get ref => ParserReference(ConstantFailureParser());
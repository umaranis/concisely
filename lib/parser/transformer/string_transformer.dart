import 'package:concisely/analyzer/grammar_optimizer.dart';
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/parser/transformer/list_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

class StringTransformer extends Transformer {

  StringTransformer(Parser parser) : super(parser) {
    removeParentParserFromStructure(this, ListTransformer);
  }

  @override
  String get label => 'String Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return parser.parse(context, OutputType.string);
  }

  @override
  bool hasEqualProperties(StringTransformer other) => true;

  @override
  void replace(Parser source, Parser target) {
    super.replace(source, target);
    removeParentParserFromStructure(this, ListTransformer);
  }
  
}


class StringFastTransformer extends StringTransformer with FastParser, ParentFastParser, DefaultFastParseResult, IntrusiveFastParser {
  StringFastTransformer(Parser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {
    return (parser as FastParser).fastParse(context, position);
  }

}
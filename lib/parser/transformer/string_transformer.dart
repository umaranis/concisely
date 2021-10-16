import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

class StringTransformer extends Transformer {

  StringTransformer(Parser parser) : super(parser);

  @override
  String get label => 'String Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return p.parse(context, OutputType.string);
  }
  
}


class StringFastTransformer extends StringTransformer with FastParser, ParentFastParser, DefaultFastParseResult, IntrusiveFastParser {
  StringFastTransformer(Parser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {
    return (p as FastParser).fastParse(context, position);
  }

}
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/default_fast_parse_result.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/times_fast_parser.dart';
import 'package:concisely/parser/transformer/string_transformer.dart';

class StringFastTransformer extends StringTransformer with FastParser, ParentFastParser, DefaultFastParseResult, IntrusiveFastParser {
  StringFastTransformer(Parser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {
    return (parser as FastParser).fastParse(context, position);
  }
  
}
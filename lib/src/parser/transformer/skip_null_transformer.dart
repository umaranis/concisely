import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// Skip the result of the parse if it is null.
/// Useful with optional and zeroOrMore parsers which may return null result in a successful parse.
///
/// Example:
///     grammar: digit.many & (char('.') & digit.many).optional.skipNull
///     input: '13'
///     result: ['1','3'] (without skipNull result would have been [['1','3'], null]
class SkipTransformer extends Transformer {
  SkipTransformer(Parser parser) : super(parser);

  @override
  String get name => 'skipNull';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, outputType);
    if(r.isSuccess && r.value == null) {
      return Success(r.context, blank);
    }
    else {
      return r;
    }
  }

  @override
  bool hasEqualProperties(SkipTransformer other) => true;

}

extension SkipNullExtensions on Parser {
  Parser get skipNull => SkipTransformer(this);
}


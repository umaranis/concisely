import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// Transform the result of a successful parse to blank value
///
/// Example:
///     grammar: digit & char('+').skip & digit
///     input: '1+3'
///     result: ['1','3']
class SkipTransformer extends Transformer {
  SkipTransformer(Parser parser) : super(parser);

  @override
  String get name => 'skip';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, outputType);
    if(r.isSuccess) {
      return Success(r.context, blank);
    }
    else {
      return r;
    }
  }

  @override
  bool hasEqualProperties(SkipTransformer other) => true;

}

extension SkipExtensions on Parser {
  Parser get skip => SkipTransformer(this);
}

class Blank {
  @override
  String toString() => '';
}

/// Skipped by Sequence Parser (not included in the list)
final blank = Blank();
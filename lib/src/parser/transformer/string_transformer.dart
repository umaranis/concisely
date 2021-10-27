import 'package:concisely/src/analyzer/grammar_optimizer.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/default_fast_parse_result.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/intrusive_fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/base/times_fast_parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/transformer/list_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

class StringTransformer extends Transformer {

  StringTransformer(Parser parser) : super(parser) {
    removeParentParserFromStructure(this, ListTransformer);
  }

  @override
  String get name => 'String Transformer';

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

/// Transforms the result into a string
///
/// Example:
///     parsing '123.34' with   digit.many & char('.') & digit.many > toString   gives us   '123.34'
///     without list transformer, the result would be a tree   [ ['1',2','3'] , '.', ['4','5'] ]
Transformer get toStr => StringTransformer(ConstantFailureParser());

extension ToStringExtension on Parser {
  /// Transforms the result into a string
  ///
  /// Example:
  ///     parsing '123.34' with   digit.many & char('.') & digit.many > toString   gives us   '123.34'
  ///     without list transformer, the result would be a tree   [ ['1',2','3'] , '.', ['4','5'] ]
  Transformer get toStr => StringTransformer(this);
}
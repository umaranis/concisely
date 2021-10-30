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
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

class StringTransformer extends Transformer<String> {

  StringTransformer(Parser parser) : super(parser) {
    removeParentParserFromStructure(this, ListTransformer);
  }

  @override
  String get name => 'String Transformer';

  @override
  Result<String> parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, OutputType.string);
    if(r.isSuccess) {
      var stringValue = r.value is List ? flatten(r.value) : r.value.toString();
      return Success(r.context, stringValue);
    }
    else {
      return Failure<String>(r.context, r.message);
    }
  }

  String flatten(List list) {
    StringBuffer buffer = new StringBuffer();
    _flatten(list, buffer);
    return buffer.toString();
  }

  void _flatten(List list, StringBuffer buffer) {
    for (var value in list) {
      if(value is List) {

      }
      else {
        buffer.write(value);
      }
    }
  }

  @override
  bool hasEqualProperties(StringTransformer other) => true;

  @override
  void replace(Parser source, Parser target) {
    super.replace(source, target);
    removeParentParserFromStructure(this, ListTransformer);
  }
  
}


class StringFastTransformer extends StringTransformer with FastParser, ParentFastParser, DefaultFastParseResult {
  StringFastTransformer(Parser parser) : super(parser);

  @override
  int fastParse(Context context, int position) {
    return (parser as FastParser).fastParse(context, position);
  }

  /// Overriding this method to provide custom implementation instead of using [IntrusiveFastParser]
  @override
  Result<String> parse(Context context, [OutputType outputType = OutputType.tree]) {
    final result = fastParse(context, context.pos);
    if(result == -1) {
      return super.parse(context, outputType);
    }

    return Success(context.moveTo(result), getFastParseResult(context, context.pos, result));
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
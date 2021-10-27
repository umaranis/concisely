import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

typedef ConsumeCallback<T> = void Function(T);

class ConsumeTransformer extends Transformer {
  final ConsumeCallback callback;
  ConsumeTransformer(Parser parser, this.callback) : super(parser);

  @override
  String get name => 'Consume Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var result = parser.parse(context);
    if(result.isSuccess) {
      callback(result.value);
      return Success(result.context, blank);
    }
    else {
      return result;
    }
  }

  @override
  bool hasEqualProperties(ConsumeTransformer other) => this.callback == other.callback;
  
}

extension MapExtensions on Parser {
  /// Consumes the result of a successful parse
  ConsumeTransformer consume(ConsumeCallback callback) {
    return ConsumeTransformer(this, callback);
  }
}

/// Consumes the result of a successful parse
ConsumeTransformer consume(ConsumeCallback callback) {
  return ConsumeTransformer(ConstantFailureParser(), callback);
}

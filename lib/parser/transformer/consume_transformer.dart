import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/skip_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/other/failure_parser.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

typedef ConsumeCallback<T> = void Function(T);

class ConsumeTransformer extends Transformer {
  final ConsumeCallback callback;
  ConsumeTransformer(Parser parser, this.callback) : super(parser);

  @override
  String get label => 'Consume Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var result = p.parse(context);
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

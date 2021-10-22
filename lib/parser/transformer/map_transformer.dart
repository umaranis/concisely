import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/other/failure_parser.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

typedef MapCallback<T> = Object Function(T value);

class MapTransformer extends Transformer {
  final MapCallback callback;
  MapTransformer(Parser parser, this.callback) : super(parser);

  @override
  String get label => 'Map Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var result = p.parse(context);
    if(result.isSuccess) {
      return Success(result.context, callback(result.value));
    }
    else {
      return result;
    }
  }

  @override
  bool hasEqualProperties(MapTransformer other) => this.callback == other.callback;
  
}

extension MapExtensions on Parser {
  /// Transforms the result of a successful parse
  MapTransformer map(MapCallback callback) {
    return MapTransformer(this, callback);
  }
}

/// Transforms the result of a successful parse
MapTransformer map(MapCallback callback) {
  return MapTransformer(ConstantFailureParser(), callback);
}

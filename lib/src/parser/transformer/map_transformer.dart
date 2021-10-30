import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

typedef MapCallback<T> = Object? Function(T value);

class MapTransformer extends Transformer {
  final MapCallback callback;
  MapTransformer(Parser parser, this.callback) : super(parser);

  @override
  String get name => 'Map Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    // ignores the given outputType. Otherwise the Type of map result will become dependent on the context and same grammar will produce string type or list type based on context.
    var result = parser.parse(context);
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

extension MapExtension on Parser {
  /// Transforms the result of a successful parse
  MapTransformer map(MapCallback callback) {
    return MapTransformer(this, callback);
  }
}

/// Transforms the result of a successful parse
MapTransformer map(MapCallback callback) {
  return MapTransformer(ConstantFailureParser(), callback);
}

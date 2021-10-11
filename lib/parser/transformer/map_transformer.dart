import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/transformer/string_fast_transformer.dart';
import 'package:concisely/parser/transformer/string_transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

typedef MapCallback<T, R> = R Function(T);

class MapTransformer extends Transformer {
  final MapCallback callback;
  MapTransformer(Parser parser, this.callback) : super(parser);

  @override
  String get label => 'Map Transformer';

  @override
  Result parse(Context context, [OutputType outputType]) {
    var result = p.parse(context);
    if(result.isSuccess) {
      return Success(result.context, callback(result.value));
    }
    else {
      return result;
    }
  }
  
}

extension MapExtensions on Parser {
  /// Transforms the result of a successful parse
  MapTransformer map(MapCallback callback) {
    return MapTransformer(this, callback);
  }

  Parser operator > (Transformer transformer) {
    if(this is FastParser && transformer is StringTransformer) {
      return StringFastTransformer(this);
    }
    else if (transformer is MapTransformer) {
      ParentParser parent = transformer;
      while(parent.p != null) {
        parent = parent.p;
      }
      parent.p = this;
      return transformer;
    }
    else {
      transformer.p = this;
      return transformer;
    }
  }
}

/// Transforms the result of a successful parse
MapTransformer map(MapCallback callback) {
  return MapTransformer(null, callback);
}

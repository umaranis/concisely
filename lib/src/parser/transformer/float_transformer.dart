import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// Transforms the results into a floating point number (double)
/// parsing 123 with   digit.many & char('.') & digit.many > toFloat   gives us <br/> 123.0
class FloatTransformer extends Transformer {
  FloatTransformer(Parser parser) : super(parser);

  @override
  String get name => 'Float Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, OutputType.string);

    if(r.isSuccess) {
      if (r.value?.isEmpty ?? true) {
        return Failure(r.context, "Failed to convert 'null' to 'float'.");
      }
      else {
        double? val = double.tryParse(r.value);
        if(val == null) {
          return Failure(r.context, "Failed to convert '${r.value}' to 'float'.");
        } else {
          return Success(r.context, val);
        }
      }
    }
    else {
      return r;
    }
  }

  @override
  bool hasEqualProperties(FloatTransformer other) => true;

}

/// Transforms the results into a floating point number (double)
/// parsing 123 with   digit.many & char('.') & digit.many > toFloat   gives us <br/> 123.0
Transformer get toFloat => FloatTransformer(ConstantFailureParser());

extension ToFloatExtensions on Parser {
  /// Transforms the results into a floating point number (double)
  /// parsing 123 with   digit.many & char('.') & digit.many > toFloat   gives us <br/> 123.0
  Transformer get toFloat => FloatTransformer(this);
}

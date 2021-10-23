import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

/// Transforms the results into a floating point number (double)
/// parsing 123 with   digit.many & char('.') & digit.many > type.float   gives us <br/> 123.0
class FloatTransformer extends Transformer {
  FloatTransformer(Parser parser) : super(parser);

  @override
  String get label => 'Float Transformer';

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
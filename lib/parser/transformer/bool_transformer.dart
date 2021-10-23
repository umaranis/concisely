import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

/// Transforms the results into a boolean value
class BooleanTransformer extends Transformer {
  BooleanTransformer(Parser parser) : super(parser);

  @override
  String get label => 'Boolean Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, OutputType.string);

    if(r.isSuccess) {
      if (r.value?.isEmpty ?? true) {
        return Failure(r.context, "Failed to convert 'null' to 'bool'.");
      }
      else {
        String lower = (r.value as String).toLowerCase();
        if(lower == 'true') {
          return Success(r.context, true);
        }
        else if(lower == 'false') {
          return Success(r.context, false);
        }
        else {
          return Failure(r.context, "Failed to convert '${r.value}' to 'bool'.");
        }
      }
    }
    else {
      return r;
    }
  }

  @override
  bool hasEqualProperties(BooleanTransformer other) => true;

}
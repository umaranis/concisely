import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// Transforms the results into a boolean value
class BooleanTransformer extends Transformer {
  BooleanTransformer(Parser parser) : super(parser);

  @override
  String get name => 'Boolean Transformer';

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

/// Transforms the results into a Boolean value (bool)
/// parsing 'True' with   letter.many > toBool   gives us <br/> true
Transformer get toBool => BooleanTransformer(ConstantFailureParser());

extension ToBoolExtensions on Parser {
  /// Transforms the results into a Boolean value (bool)
  /// parsing 'True' with   letter.many > toBool   gives us <br/> true
  Transformer get toBool => BooleanTransformer(this);
}
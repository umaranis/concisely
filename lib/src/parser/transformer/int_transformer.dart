import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

class IntTransformer extends Transformer {
  IntTransformer(Parser parser) : super(parser);

  @override
  String get name => 'Integer Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, OutputType.string);

    if(r.isSuccess) {
      if (r.value?.isEmpty ?? true) {
        return Failure(r.context, "Failed to convert 'null' to 'int'.");
      }
      else {
        int? val = int.tryParse(r.value);
        if(val == null) {
          return Failure(r.context, "Failed to convert '${r.value}' to 'int'.");
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
  bool hasEqualProperties(IntTransformer other) => true;

}

/// Transforms the results into an integer
/// parsing 123 with   digit.many & char('.') & digit.many > toInt   gives us <br/> 123
Transformer get toInt => IntTransformer(ConstantFailureParser());

extension ToIntExtensions on Parser {
  /// Transforms the results into an integer
  /// parsing 123 with   digit.many & char('.') & digit.many > toInt   gives us <br/> 123
  Transformer get toInt => IntTransformer(this);
}
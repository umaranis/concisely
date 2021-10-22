import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class IntTransformer extends Transformer {
  IntTransformer(Parser parser) : super(parser);

  @override
  String get label => 'Integer Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = p.parse(context, OutputType.string);

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
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import '../base/parser.dart';

/// Just fails without consuming anything
class ConstantFailureParser extends Parser {
  ConstantFailureParser._internal();

  static ConstantFailureParser _instance = ConstantFailureParser._internal();

  factory ConstantFailureParser() {
    return _instance;
  }

  @override
  String get label => 'Constant Failure Parser';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return Failure(context, 'Constant Failure Parser encountered');
  }

}


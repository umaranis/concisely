import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import '../base/parser.dart';

/// Just fails without consuming anything
class ConstantFailureParser extends Parser {
  ConstantFailureParser._internal();

  static ConstantFailureParser _instance = ConstantFailureParser._internal();

  factory ConstantFailureParser() {
    return _instance;
  }

  @override
  String get name => 'Constant Failure Parser';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return Failure(context, 'Constant Failure Parser encountered');
  }

  @override
  bool hasEqualProperties(ConstantFailureParser other) => true;

}


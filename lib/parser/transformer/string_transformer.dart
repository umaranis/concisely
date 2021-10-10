import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

class StringTransformer extends Transformer {

  StringTransformer(Parser parser) : super(parser);

  @override
  String get label => 'String Tranformer';

  @override
  Result parse(Context context, [OutputType outputType]) {
    return p.parse(context, OutputType.string);
  }
  
}
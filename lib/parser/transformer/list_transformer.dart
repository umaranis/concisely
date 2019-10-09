import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

class ListTransformer extends Transformer {

  ListTransformer(Parser parser) : super(parser);

  @override
  String get label => 'String Tranformer';

  @override
  Result parse(Context context, [OutputType outputType]) {
    return parser.parse(context, OutputType.list);    
  }
  
}
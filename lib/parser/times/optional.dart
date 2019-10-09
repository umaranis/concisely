import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class OptionalParser extends ParentParser {
  
  OptionalParser(Parser parser) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType]) {
    var r = parser.parse(context, outputType);
    if(r.isSuccess) {
      return r;
    }
    else {
      return Success(context, null);
    }    
  }

  @override
  String get label => '${parser.label} optional';
  
}
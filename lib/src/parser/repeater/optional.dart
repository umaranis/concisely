import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

class OptionalParser extends ParentParser {
  
  OptionalParser(Parser parser) : super(parser);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var r = parser.parse(context, outputType);
    if(r.isSuccess) {
      return r;
    }
    else {
      return Success(context, null);
    }    
  }

  @override
  String get name => '${parser.name} optional';

  @override
  bool hasEqualProperties(OptionalParser other) => true;
  
}
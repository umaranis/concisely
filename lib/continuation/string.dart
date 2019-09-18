import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class StringParser extends Parser{
  final Parser parser;

  StringParser(this.parser);
  
  @override
  Result parse(Context context) {
    var result = parser.parse(context);
    if(result.isSuccess) {
      return Success(result.context, context.substring(result.context.pos));    
    }
    else {
      return result;
    }
  }

  @override
  String get label => "String converter";
  
}
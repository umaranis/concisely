import 'package:dallang/context.dart';
import 'package:dallang/result/result.dart';
import 'package:dallang/result/success.dart';
import '../parser.dart';

class StringParser extends Parser{
  final Parser parser;

  StringParser(this.parser);
  
  @override
  Result parse(Context context) {
    var result = parser.parse(context);
    if(result.isSuccess) {
      return Success(result.context, context.line.substring(context.pos.col, result.context.pos.col));    
    }
    else {
      return result;
    }
  }
  
}
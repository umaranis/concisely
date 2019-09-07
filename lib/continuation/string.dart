import 'package:conciseparser/parser/base/parser.dart';
import 'package:conciseparser/context.dart';
import 'package:conciseparser/result/result.dart';
import 'package:conciseparser/result/success.dart';

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
  
}
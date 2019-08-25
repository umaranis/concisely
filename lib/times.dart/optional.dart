import 'package:conciseparser/context.dart';
import 'package:conciseparser/parser.dart';
import 'package:conciseparser/result/result.dart';
import 'package:conciseparser/result/success.dart';

class OptionalParser extends Parser {
  final Parser parser;
  OptionalParser(this.parser);

  @override
  Result parse(Context context) {
    var r = parser.parse(context);
    if(r.isSuccess) {
      return r;
    }
    else {
      return Success(context, null);
    }    
  }
  
}
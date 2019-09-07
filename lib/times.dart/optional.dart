import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

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
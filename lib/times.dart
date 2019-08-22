import 'package:dallang/context.dart';
import 'package:dallang/failure.dart';
import 'package:dallang/parser.dart';
import 'package:dallang/result.dart';
import 'package:dallang/success.dart';

class TimesParser extends Parser<List> {
  final Parser parser;
  final int times;

  TimesParser(this.parser, this.times);

  @override
  Result<List> parse(Context context) {
    var list = [];
    var current = context;
    for(int i = 0; i < times; i++) {
      var result = parser.parse(current);
      if(result.isSuccess) {
        list.add(result.value);
        current = result.context;
      }
      else {
        return Failure(current, result.message);
      }
    }   

    return Success(current, list);
  }

}
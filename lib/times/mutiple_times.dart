import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class MultipleTimesParser extends Parser {
  final Parser parser;
  final int times;

  MultipleTimesParser(this.parser, this.times);

  @override
  Result parse(Context context) {    
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

  @override
  String get label => '${parser.label} * ${times} times';

}
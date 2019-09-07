import 'package:conciseparser/parser/base/parser.dart';
import 'package:conciseparser/context.dart';
import 'package:conciseparser/result/failure.dart';
import 'package:conciseparser/result/result.dart';
import 'package:conciseparser/result/success.dart';

class MultipleTimesParser extends Parser<List> {
  final Parser parser;
  final int times;

  MultipleTimesParser(this.parser, this.times);

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
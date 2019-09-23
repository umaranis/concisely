import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/times_parser.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class MultipleTimesParser extends TimesParser {  
  final int times;

  MultipleTimesParser(Parser parser, this.times) : super(parser);

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

  @override
  String get label => '${parser.label} * ${times} times';

}
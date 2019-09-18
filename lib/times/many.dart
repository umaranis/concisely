import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

/// Repeats the given parser one or more times.
/// Also called plus (+) or 1+ in some parsing systems.
class ManyParser extends Parser<List> {
  final Parser parser;  

  ManyParser(this.parser);

  @override
  Result<List> parse(Context context) {    
    var list = [];
    var current = context;
    
    var result = parser.parse(current);
    if(result.isSuccess) {
      list.add(result.value);
      current = result.context;
    }
    else {
      return Failure(current, result.message);
    }
    
    while(true) {
      result = parser.parse(current);
      if(result.isSuccess) {
        list.add(result.value);
        current = result.context;
      }
      else {
        return Success(current, list);
      }
    }
  }

}
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/result.dart';
import 'parser/base/parser.dart';
import 'exception.dart';

T parseOrThrow<T>(String input, Parser parser) { 
  //parser = parser & eof;
  var result = parser.parse(Context(input, 0));
  if(result.isSuccess) {
    return result.value;
  }
  else {
    throw ParseException(result);
  }
}

Result parse(String input, Parser parser) {  
  //parser = parser & eof;
  var result = parser.parse(Context(input, 0));
  return result;  
}




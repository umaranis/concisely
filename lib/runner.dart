import 'package:dallang/context.dart';
import 'package:dallang/parser.dart';
import 'package:dallang/result/result.dart';

import 'exception.dart';

T parseOrThrow<T>(String input, Parser parser) {  
  var result = parser.parse(Context(input, 0));
  if(result.isSuccess) {
    return result.value;
  }
  else {
    throw ParseException(result);
  }
}

Result parse(String input, Parser parser) {  
  var result = parser.parse(Context(input, 0));
  return result;  
}




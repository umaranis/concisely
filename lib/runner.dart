import 'package:conciseparser/context.dart';
import 'package:conciseparser/parser.dart';
import 'package:conciseparser/result/result.dart';

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




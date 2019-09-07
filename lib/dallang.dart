import 'dart:io';
import 'package:conciseparser/context.dart';
import 'package:conciseparser/parser/char/char.dart';
import 'parser/base/parser.dart';

Future<String> readFile(String path) {
  var file = File(path);
  return file.readAsString();   
}

void parse(String text) {  

  Parser p = char("9");
  print(p.parse(Context("99", 0)).value); 
  
}
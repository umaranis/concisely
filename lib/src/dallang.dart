import 'dart:io';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/char/char.dart';

Future<String> readFile(String path) {
  var file = File(path);
  return file.readAsString();   
}

void parse(String text) {  

  Parser p = char("9");
  print(p.parse(Context("99", 0)).value); 
  
}
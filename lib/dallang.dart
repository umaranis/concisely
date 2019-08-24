import 'dart:io';
import 'package:dallang/char.dart';
import 'package:dallang/context.dart';
import 'package:dallang/parser.dart';

int calculate() {
  return 6 * 7;
}

Future<String> readFile(String path) {
  var file = File(path);
  return file.readAsString();   
}

void parse(String text) {  

  Parser p = char("9");
  print(p.parse(Context("99", 0)).value); 
  
}
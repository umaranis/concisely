import 'dart:io';
import 'package:dallang/char.dart';
import 'package:dallang/context.dart';
import 'package:dallang/parser.dart';
import 'package:dallang/position.dart';

int calculate() {
  return 6 * 7;
}

Future<String> readFile(String path) {
  var file = File(path);
  return file.readAsString();   
}

void parse(String text) {
  var object = Map();  

  int pointer = 0;

  Parser p = char("9");
  print(p.parse(Context(["99"], Position(0,0,0))).value); 
  
}
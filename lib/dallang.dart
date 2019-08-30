import 'dart:io';
import 'package:conciseparser/context.dart';
import 'package:conciseparser/parser.dart';
import 'package:conciseparser/parser/char.dart';

Future<String> readFile(String path) {
  var file = File(path);
  return file.readAsString();   
}

void parse(String text) {  

  Parser p = char("9");
  print(p.parse(Context("99", 0)).value); 
  
}
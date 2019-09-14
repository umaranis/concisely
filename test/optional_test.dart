import 'package:concisely/continuation/string.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/times/times.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  test('optional', () {

    var grammar = 
    StringParser(
      char("A") * 5
      & 
      char("G") * 2 * optional
    );    
    
    expectSuccess(
      parse("AAAAA", grammar), 
      "AAAAA");
  }); 

  
}
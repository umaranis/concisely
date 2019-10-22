import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  test('optional fast parser', () {

    var grammar = 
      char("A") * 5
      & 
      char("G") * 2 * optional

      > string
    ;    
    
    expectSuccess(
      parse("AAAAA", grammar), 
      "AAAAA");
  });

  test('optional', () {

    var grammar =
        char("A") * 5
        &
        char("G") * 2 * optional
    ;

    expectSuccess(
        parse("AAAAA", grammar),
        [['A', 'A', 'A', 'A', 'A']]);
  });


}
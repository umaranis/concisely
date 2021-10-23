import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';

import '../../helper.dart';

void main() {
  test('default', () {
    var grammar = char('A') * 5 & char('G') * 2;
    expect(
      parseOrThrow('AAAAAGG', grammar),
      [['A', 'A', 'A', 'A', 'A'], ['G', 'G']]);
  });

  test('tree', () {
    var grammar = char('A') * 5 & char('G') * 2   ;
    expectSuccess(
      parse('AAAAAGG', grammar),
      [['A', 'A', 'A', 'A', 'A'], ['G', 'G']]);
  });

  test('email somewhat', () {
    var grammar = letter 
                  & 
                  (letter | digit | char('.') ) * many
                  &
                  char('@')
                  &
                  (letter | digit) * many
                  & 
                  char('.')
                  &
                  letter * 3
                  
                  ;

    expectSuccess(
      parse('hello.world@gmail.com', grammar),
      [
        'h',
        ['e', 'l', 'l', 'o', '.', 'w', 'o', 'r', 'l', 'd'],
        '@',
        ['g', 'm', 'a', 'i', 'l'],
        '.',
        ['c', 'o', 'm']
      ]
    );
  });

}
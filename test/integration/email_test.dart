import 'package:concisely/debug/progress.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';

import '../expect_parse_helper.dart';

void main() {
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

    expectParse.pass(progress(grammar),
      "hello.world@gmail.com",
      [
        'h',
        ['e', 'l', 'l', 'o', '.', 'w', 'o', 'r', 'l', 'd'],
        '@',
        ['g', 'm', 'a', 'i', 'l'],
        '.',
        ['c', 'o', 'm']
      ]
    );

    expectParse.pass(grammar,
      "hello.world@gmail.com",
      [
        'h',
        ['e', 'l', 'l', 'o', '.', 'w', 'o', 'r', 'l', 'd'],
        '@',
        ['g', 'm', 'a', 'i', 'l'],
        '.',
        ['c', 'o', 'm']
      ]
    );

    expectParse.pass(grammar > type.string,
      "hh@gmail.com",
      "hh@gmail.com"
    );

    expectParse.pass(grammar,
      "hh@gmail.com",
      ['h', ['h'], '@', ['g', 'm', 'a', 'i', 'l'], '.', ['c', 'o', 'm']]
    );
    
  });
}
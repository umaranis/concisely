import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
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

    expectParse.pass(grammar > toStr,
      "hh@gmail.com",
      "hh@gmail.com"
    );

    expectParse.pass(grammar,
      "hh@gmail.com",
      ['h', ['h'], '@', ['g', 'm', 'a', 'i', 'l'], '.', ['c', 'o', 'm']]
    );
    
  });
}
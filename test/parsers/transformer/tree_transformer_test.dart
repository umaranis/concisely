import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {
  test('default', () {
    var grammar = char('A') * 5 & char('G') * 2;
    expect(
      parseOrThrow('AAAAAGG', grammar),
      [['A', 'A', 'A', 'A', 'A'], ['G', 'G']]);
  });

  test('tree', () {
    var grammar = char('A') * 5 & char('G') * 2   > toTree;
    expectParse.pass(grammar,
      'AAAAAGG',
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
                  
                  > toTree
                  ;

    expectParse.pass(grammar,
      'hello.world@gmail.com',
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

  test('tree trace', () {
    var grammar = char('A') * 5 & char('G') * 2   > toTree;
    expectParse.debugTrace(grammar, 'AAAAAGG',
      [['A', 'A', 'A', 'A', 'A'], ['G', 'G']],
      'TreeTransformer'
    );
  });

}
import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {

  test('zeroOrMore', () {
    var grammar = any.zeroOrMore;
    expectParse.pass(grammar,
      '123ABC@',
      ['1', '2', '3', 'A', 'B', 'C', '@']);
  });  

  test('zeroOrMore 1', () {
    var grammar = any.zeroOrMore;
    expectParse.pass(grammar,
      '1',
      ['1']);
  });

  test('zeroOrMore 0', () {
    var grammar = char('f').zeroOrMore;
    expectParse.pass(grammar,
        '1',
        null);
  });

  test('zeroOrMore, fast parse', () {
    var grammar = (digit & letter).zeroOrMore
      > toStr;
    expectParse.pass(grammar,
        '1a2bc3',
        '1a2b');
  });

  test('zeroOrMore, 0 matches, fast parse', () {
    var grammar = (digit & letter).zeroOrMore
        > toStr;
    expectParse.pass(grammar,
        'a2bc3',
        '');
  });



}
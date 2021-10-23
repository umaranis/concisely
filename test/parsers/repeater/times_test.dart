import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {

  test('7 times', () {
    var grammar =  (char('A') | char('\n')) * 7   > type.string;
    expectParse.pass(grammar,
      "AAA\nAA\n",
      "AAA\nAA\n");
  });

  test('times list', () {
    var grammar = char('A') * 3;
    expectParse.pass(grammar,
      "AAA",
      ['A','A','A']);
  });
}
import 'package:concisely/concisely.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {

  test('7 times', () {
    var grammar =  (char('A') | char('\n')) * 7   > toStr;
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
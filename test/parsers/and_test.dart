import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../expect_parse_helper.dart';

void main() {
  test('andParser', () {
    var grammar = char('A') * 5 & char('G') * 2 > toStr;
    expectParse.pass(grammar,
      'AAAAAGG',
      'AAAAAGG');
  });

  test('andParser 2', () {
    var grammar = char('A') * 5 & char('G') * 2 > toStr;
    expectParse.pass(grammar,
      'AAAAAGG',
      'AAAAAGG');
  });
}
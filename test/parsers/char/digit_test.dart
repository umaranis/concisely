import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';


void main() {
  test('digit', () {
    var grammar = digit > toStr;
    expectParse.pass(grammar, '1', '1');
  });

  test('digits', () {
    var grammar = digit * 3 > toStr;
    expectParse.pass(grammar, '123', '123');
  });

  test('digits fail', () {
    var grammar = digit * 3 > toStr;
    expectParse.fail(grammar, '12');
  });

  test('digit fail', () {
    var grammar = digit > toStr;
    expectParse.fail(grammar, 'A');
  });
}
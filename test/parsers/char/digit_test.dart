
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';


void main() {
  test('digit', () {
    var grammar = digit > type.string;
    expectParse.pass(grammar, '1', '1');
  });

  test('digits', () {
    var grammar = digit * 3 > type.string;
    expectParse.pass(grammar, '123', '123');
  });

  test('digits fail', () {
    var grammar = digit * 3 > type.string;
    expectParse.fail(grammar, '12');
  });

  test('digit fail', () {
    var grammar = digit > type.string;
    expectParse.fail(grammar, 'A');
  });
}
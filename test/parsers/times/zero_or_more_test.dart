import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('zeroOrMore', () {
    var grammar = any.zeroOrMore;
    expectSuccess(
      parse('123ABC@', grammar),
      ['1', '2', '3', 'A', 'B', 'C', '@']);
  });  

  test('zeroOrMore 1', () {
    var grammar = any.zeroOrMore;
    expectSuccess(
      parse('1', grammar),
      ['1']);
  });

  test('zeroOrMore 0', () {
    var grammar = char('f').zeroOrMore;
    expectSuccess(
        parse('1', grammar),
        []);
  });

  test('zeroOrMore, fast parse', () {
    var grammar = (digit & letter).zeroOrMore
      > type.string;
    expectSuccess(
        parse('1a2bc3', grammar),
        '1a2b');
  });

  test('zeroOrMore, 0 matches, fast parse', () {
    var grammar = (digit & letter).zeroOrMore
        > type.string;
    expectSuccess(
        parse('a2bc3', grammar),
        '');
  });



}
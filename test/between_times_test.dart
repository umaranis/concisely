import 'package:concisely/debug/trace.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';
import 'helper.dart';

void main() {

  test('between pass', () {
    var grammar = any * between(3, 6);
    expectSuccess(
        parse("123ABC@", grammar),
        ['1', '2', '3', 'A', 'B', 'C']);
  });

  test('between pass - any 7', () {
    var grammar = any * between(7, 7);
    expectSuccess(
        parse("123ABC@", grammar),
        ['1', '2', '3', 'A', 'B', 'C', '@']);
  });

  test('between fail', () {
    var grammar = any * between(8,10);
    expectFailure(
        parse("123ABC@", grammar),
        );
  });

  test('between 0 to 1', () {
    var grammar = letter * between(0,1);
    expectSuccess(
        parse("a", grammar),
        ['a']);
  });

  test('between 1', () {
    var grammar = letter * between(1,1);
    expectSuccess(
        parse("a", grammar),
        ['a']);
  });

  test('between 1 trace', () {
    var grammar = letter * between(1, 1);
    expectSuccess(
        parse("a", trace(grammar)),
        ['a']);
  });

  test('between as optional', () {
    var grammar = letter * between(0, 1);
    expectSuccess(
        parse("", trace(grammar)),
        []);
  });

  test('between times parser among others', () {
    var grammar = letter * 2 & digit * between(2, 5) & letter * 2;
    expectSuccess(
        parse("AB1234AB", grammar),
        [['A', 'B'], ['1', '2', '3', '4'], ['A', 'B']]);
  });



}
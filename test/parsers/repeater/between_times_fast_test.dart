import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('between pass', () {
    var grammar = any * between(3, 6)
        > toStr;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC');
  });

  test('between pass - any 7', () {
    var grammar = any * between(7, 7)
        > toStr;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC@');
  });

  test('between fail', () {
    var grammar = any * between(8,10)
        > toStr;
    expectFailure(
        parse('123ABC@', grammar),
        );
  });

  test('between 0 to 1', () {
    var grammar = letter * between(0,1)
        > toStr;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('between 1', () {
    var grammar = letter * between(1,1)
        > toStr;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('between 1 trace', () {
    var grammar = letter * between(1, 1)
        > toStr;
    expectSuccess(
        parse('a', trace(grammar)),
        'a');
  });

  test('between as optional', () {
    var grammar = letter * between(0, 1)
        > toStr;
    expectSuccess(
        parse('', trace(grammar)),
        '');
  });

  test('between times parser among others', () {
    var grammar = letter * 2 & digit * between(2, 5) & letter * 2
        > toStr;
    expectSuccess(
        parse('AB1234AB', grammar),
        'AB1234AB');
  });

  test('between 1 trace', () {
    var grammar = letter * between(1,1)
      > toStr;
    expectTrace(grammar, 'a', 'a', 'BetweenTimesFastParser');
  });

  test('between 1 fast parse', () {
    var grammar = letter * between(1,10)
        > toStr;
    expectProgress(grammar, 'a', 'a', '<fast parse>');
  });

  test('between 1 slow parse', () {
    var grammar = (letter > toList) * between(1,10)
        > toStr;
    expectProgress(grammar, 'a', 'a', '<fast parse>', false);
  });

}
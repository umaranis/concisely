import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('min pass', () {
    var grammar = any * min(3)
        > toStr;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC@');
  });

  test('min pass - any 7', () {
    var grammar = any * min(7)
        > toStr;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC@');
  });

  test('min fail', () {
    var grammar = any * min(8)
        > toStr;
    expectFailure(
        parse('123ABC@', grammar),
        );
  });

  test('min 1', () {
    var grammar = letter * min(0)
        > toStr;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('min 1', () {
    var grammar = letter * min(1)
        > toStr;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('min 1 trace', () {
    var grammar = letter * min(1)
        > toStr;
    expectTrace(grammar, 'a', 'a', 'MinTimesFastParser');
  });

  test('min 1 fast parse', () {
    var grammar = letter * min(1)
      > toStr;
    expectProgress(grammar, 'a', 'a', '<fast parse>');
  });

  test('min 1 slow parse', () {
    var grammar = (letter > toList) * min(1)
        > toStr;
    expectProgress(grammar, 'a', 'a', '<fast parse>', false);
  });

}
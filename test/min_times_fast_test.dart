import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';
import 'helper.dart';

void main() {

  test('min pass', () {
    var grammar = any * min(3)
        > string;
    expectSuccess(
        parse("123ABC@", grammar),
        "123ABC@");
  });

  test('min pass - any 7', () {
    var grammar = any * min(7)
        > string;
    expectSuccess(
        parse("123ABC@", grammar),
        "123ABC@");
  });

  test('min fail', () {
    var grammar = any * min(8)
        > string;
    expectFailure(
        parse("123ABC@", grammar),
        );
  });

  test('min 1', () {
    var grammar = letter * min(0)
        > string;
    expectSuccess(
        parse("a", grammar),
        'a');
  });

  test('min 1', () {
    var grammar = letter * min(1)
        > string;
    expectSuccess(
        parse("a", grammar),
        'a');
  });

  test('min 1 trace', () {
    var grammar = letter * min(1)
        ;
    expectTrace(grammar, 'a', 'a', 'MinTimesFastParser');
  });

  test('min 1 fast parse', () {
    var grammar = letter * min(1)
      > string;
    expectProgress(grammar, 'a', 'a', '<fast parse>');
  });

}
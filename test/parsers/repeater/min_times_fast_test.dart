import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('min pass', () {
    var grammar = any * min(3)
        > type.string;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC@');
  });

  test('min pass - any 7', () {
    var grammar = any * min(7)
        > type.string;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC@');
  });

  test('min fail', () {
    var grammar = any * min(8)
        > type.string;
    expectFailure(
        parse('123ABC@', grammar),
        );
  });

  test('min 1', () {
    var grammar = letter * min(0)
        > type.string;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('min 1', () {
    var grammar = letter * min(1)
        > type.string;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('min 1 trace', () {
    var grammar = letter * min(1)
        > type.string;
    expectTrace(grammar, 'a', 'a', 'MinTimesFastParser');
  });

  test('min 1 fast parse', () {
    var grammar = letter * min(1)
      > type.string;
    expectProgress(grammar, 'a', 'a', '<fast parse>');
  });

  test('min 1 slow parse', () {
    var grammar = (letter > type.list) * min(1)
        > type.string;
    expectProgress(grammar, 'a', 'a', '<fast parse>', false);
  });

}
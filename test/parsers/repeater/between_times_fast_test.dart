import 'package:concisely/debug/trace.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('between pass', () {
    var grammar = any * between(3, 6)
        > type.string;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC');
  });

  test('between pass - any 7', () {
    var grammar = any * between(7, 7)
        > type.string;
    expectSuccess(
        parse('123ABC@', grammar),
        '123ABC@');
  });

  test('between fail', () {
    var grammar = any * between(8,10)
        > type.string;
    expectFailure(
        parse('123ABC@', grammar),
        );
  });

  test('between 0 to 1', () {
    var grammar = letter * between(0,1)
        > type.string;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('between 1', () {
    var grammar = letter * between(1,1)
        > type.string;
    expectSuccess(
        parse('a', grammar),
        'a');
  });

  test('between 1 trace', () {
    var grammar = letter * between(1, 1)
        > type.string;
    expectSuccess(
        parse('a', trace(grammar)),
        'a');
  });

  test('between as optional', () {
    var grammar = letter * between(0, 1)
        > type.string;
    expectSuccess(
        parse('', trace(grammar)),
        '');
  });

  test('between times parser among others', () {
    var grammar = letter * 2 & digit * between(2, 5) & letter * 2
        > type.string;
    expectSuccess(
        parse('AB1234AB', grammar),
        'AB1234AB');
  });

  test('between 1 trace', () {
    var grammar = letter * between(1,1)
      > type.string;
    expectTrace(grammar, 'a', 'a', 'BetweenTimesFastParser');
  });

  test('between 1 fast parse', () {
    var grammar = letter * between(1,10)
        > type.string;
    expectProgress(grammar, 'a', 'a', '<fast parse>');
  });

  test('between 1 slow parse', () {
    var grammar = (letter > type.list) * between(1,10)
        > type.string;
    expectProgress(grammar, 'a', 'a', '<fast parse>', false);
  });

}
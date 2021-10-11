import 'package:concisely/debug/trace.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('min pass', () {
    var grammar = any * min(3);
    expectSuccess(
        parse('123ABC@', grammar),
        ['1', '2', '3', 'A', 'B', 'C', '@']);
  });

  test('min pass - any 7', () {
    var grammar = any * min(7);
    expectSuccess(
        parse('123ABC@', grammar),
        ['1', '2', '3', 'A', 'B', 'C', '@']);
  });

  test('min fail', () {
    var grammar = any * min(8);
    expectFailure(
        parse('123ABC@', grammar),
        );
  });

  test('min 1', () {
    var grammar = letter * min(0);
    expectSuccess(
        parse('a', grammar),
        ['a']);
  });

  test('min 1', () {
    var grammar = letter * min(1);
    expectSuccess(
        parse('a', grammar),
        ['a']);
  });

  test('min 1', () {
    var grammar = letter * min(1);
    expectSuccess(
        parse('a', trace(grammar)),
        ['a']);
  });



}
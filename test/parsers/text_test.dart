import 'package:concisely/debug/trace.dart';
import 'package:concisely/exception.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/parser/text/text.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {

  test('text', () {
    var grammar = text('hello world');
    expect(
        parseOrThrow('hello world', grammar),
        'hello world');
  });

  test('text exception', () {
    var grammar = text('game');
    expect(
            () => parseOrThrow('gam', grammar),
        throwsA((e) => e is ParseException));
  });

  test('text fail', () {
    var grammar = text('game');
    expectFailure(parse('gam', grammar));
  });

  test('text trace', () {
    var grammar = text('game');
    expectTrace(grammar, 'game', 'game', 'TextParser');
  });

  test('text among other parsers', () {
    var grammar = letter * 5 & whitespace & text('world!') & char('!');
    expectSuccess(parse('hello world!!', grammar),
        [['h', 'e', 'l', 'l', 'o'], ' ', 'world!', '!']
    );
  });

  test('text fast parsing', () {
    var grammar = letter * 5 & whitespace & text('world!') & char('!')
      > type.string;
    expectTrace(grammar, 'hello world!!', 'hello world!!', 'TextParser  ["world!"]   <fast parse>\n    Success[12]:');
  });

  test('text fast parsing fail', () {
    var grammar = letter * 5 & whitespace & text('world!') & text('!')
        > type.string;
    expectFailure(parse('hello world!', trace(grammar)));
  });

  test('text fast string transformer', () {
    var grammar = text('hello') & whitespace & letter * many
        > type.string;
    expectTrace(grammar, 'hello world', 'hello world', 'StringFastTransformer');
  });

  test('text fast parsing result', () {
    var grammar = (text('hello') > type.string) & (whitespace > type.list)
        > type.string;
    expectSuccess(parse('hello world', trace(grammar)), 'hello ');
  });

  test('text label', () {
    var grammar = text('1\n2\n3');
    expect('"1\\n2\\n3"', grammar.label);
  });
}
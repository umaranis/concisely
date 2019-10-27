import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/parser/text/text.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {

  test('text', () {
    var grammar = text("hello world");
    expect(
        parseOrThrow("hello world", grammar),
        "hello world");
  });

  test('text exception', () {
    var grammar = text('game');
    expect(
            () => parseOrThrow("gam", grammar),
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
      > string;
    expectTrace(grammar, 'hello world!!', 'hello world!!', 'TextParser  ["world!"]   <fast parse>\n    Success[12]:');
  });

  test('text label', () {
    var grammar = text('1\n2\n3');
    expect('"1\\n2\\n3"', grammar.label);
  });
}
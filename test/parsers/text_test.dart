import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {

  test('text', () {
    var grammar = str('hello world');
    expect(
        parseOrThrow('hello world', grammar),
        'hello world');
  });

  test('text exception', () {
    var grammar = str('game');
    expect(
            () => parseOrThrow('gam', grammar),
        throwsA((e) => e is ParseException));
  });

  test('text fail', () {
    var grammar = str('game');
    expectFailure(parse('gam', grammar));
  });

  test('text trace', () {
    var grammar = str('game');
    expectTrace(grammar, 'game', 'game', 'StringParser');
  });

  test('text among other parsers', () {
    var grammar = letter * 5 & whitespace & str('world!') & char('!');
    expectSuccess(parse('hello world!!', grammar),
        [['h', 'e', 'l', 'l', 'o'], ' ', 'world!', '!']
    );
  });

  test('text fast parsing', () {
    var grammar = letter * 5 & whitespace & str('world!') & char('!')
      > toStr;
    expectTrace(grammar, 'hello world!!', 'hello world!!', 'StringParser  ["world!"]   <fast parse>\n    Success[12]:');
  });

  test('text fast parsing fail', () {
    var grammar = letter * 5 & whitespace & str('world!') & str('!')
        > toStr;
    expectFailure(parse('hello world!', trace(grammar)));
  });

  test('text fast string transformer', () {
    var grammar = str('hello') & whitespace & letter * many
        > toStr;
    expectTrace(grammar, 'hello world', 'hello world', 'StringFastTransformer');
  });

  test('text fast parsing result', () {
    var grammar = (str('hello') > toStr) & (whitespace > toList)
        > toStr;
    expectSuccess(parse('hello world', trace(grammar)), 'hello ');
  });

  test('text label', () {
    var grammar = str('1\n2\n3');
    expect('"1\\n2\\n3"', grammar.name);
  });
}
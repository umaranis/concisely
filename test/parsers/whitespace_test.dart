import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() {
  test('space', () {
    var grammar = whitespace > type.string;
    expect(
      parseOrThrow(' ', grammar),
      ' ');
  });

  test('spaces', () {
    var grammar = whitespace * 3 > type.string;
    expect(
      parseOrThrow('   ', grammar),
      '   ');
  });

  test('newline', () {
    var grammar = whitespace * 3 > type.string;
    expect(
      parseOrThrow('\n\n\n', grammar),
      '\n\n\n');
  });

  test('carriageReturn', () {
    var grammar = whitespace > type.string;
    expect(
      parseOrThrow('\r', grammar),
      '\r');
  });

  test('carriageReturn', () {
    var grammar = whitespace & whitespace > type.string;
    expect(
      parseOrThrow('\r\n', grammar),
      '\r\n');
  });

  test('newlineTab', () {
    var grammar = whitespace * 2 > type.string;
    expect(
      parseOrThrow('\t\n', grammar),
      '\t\n');
  });

  test('tab', () {
    var grammar = whitespace > type.string;
    expect(
      parseOrThrow('\t', grammar),
      '\t');
  });

  test('whitespaceFail', () {
    var grammar = whitespace > type.string;
    expect(
      () => parseOrThrow('a', grammar),
      throwsA((e) => e is ParseException));
  });  

    test('whitespace Unicode', () {
    var grammar = whitespace > type.string;
    expect(
      () => parseOrThrow('\u{5760}', grammar),
      throwsA((e) => e is ParseException));
  });  
}
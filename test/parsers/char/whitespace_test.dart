import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() {
  test('space', () {
    var grammar = whitespace > toStr;
    expect(
      parseOrThrow(' ', grammar),
      ' ');
  });

  test('spaces', () {
    var grammar = whitespace * 3 > toStr;
    expect(
      parseOrThrow('   ', grammar),
      '   ');
  });

  test('newline', () {
    var grammar = whitespace * 3 > toStr;
    expect(
      parseOrThrow('\n\n\n', grammar),
      '\n\n\n');
  });

  test('carriageReturn', () {
    var grammar = whitespace > toStr;
    expect(
      parseOrThrow('\r', grammar),
      '\r');
  });

  test('carriageReturn', () {
    var grammar = whitespace & whitespace > toStr;
    expect(
      parseOrThrow('\r\n', grammar),
      '\r\n');
  });

  test('newlineTab', () {
    var grammar = whitespace * 2 > toStr;
    expect(
      parseOrThrow('\t\n', grammar),
      '\t\n');
  });

  test('tab', () {
    var grammar = whitespace > toStr;
    expect(
      parseOrThrow('\t', grammar),
      '\t');
  });

  test('whitespaceFail', () {
    var grammar = whitespace > toStr;
    expect(
      () => parseOrThrow('a', grammar),
      throwsA((e) => e is ParseException));
  });  

    test('whitespace Unicode', () {
    var grammar = whitespace > toStr;
    expect(
      () => parseOrThrow('\u{5760}', grammar),
      throwsA((e) => e is ParseException));
  });  
}
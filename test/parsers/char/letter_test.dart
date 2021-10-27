import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() {
  test('letter', () {
    var grammar = letter > toStr;
    expect(
      parseOrThrow('x', grammar),
      'x');
  });

  test('letters', () {
    var grammar = letter * 3 > toStr;
    expect(
      parseOrThrow('xyz', grammar),
      'xyz');
  });

  test('capitalLetters', () {
    var grammar = letter * 3 > toStr;
    expect(
      parseOrThrow('XYZ', grammar),
      'XYZ');
  });

  test('lettersFail', () {
    var grammar = letter * 3 > toStr;
    expect(
      () => parseOrThrow('ab', grammar),
      throwsA((e) => e is ParseException));
  });

  test('letterFail', () {
    var grammar = letter > toStr;
    expect(
      () => parseOrThrow('1', grammar),
      throwsA((e) => e is ParseException));
  });
}
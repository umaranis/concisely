
import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() {
  test('letter', () {
    var grammar = letter > string;
    expect(
      parseOrThrow("x", grammar), 
      "x");
  });

  test('letters', () {
    var grammar = letter * 3 > string;
    expect(
      parseOrThrow("xyz", grammar), 
      "xyz");
  });

  test('capitalLetters', () {
    var grammar = letter * 3 > string;
    expect(
      parseOrThrow("XYZ", grammar), 
      "XYZ");
  });

  test('lettersFail', () {
    var grammar = letter * 3 > string;
    expect(
      () => parseOrThrow("ab", grammar), 
      throwsA((e) => e is ParseException));
  });

  test('letterFail', () {
    var grammar = letter > string;
    expect(
      () => parseOrThrow("1", grammar), 
      throwsA((e) => e is ParseException));
  });
}
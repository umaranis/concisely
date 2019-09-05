import 'package:conciseparser/continuation/string.dart';
import 'package:conciseparser/exception.dart';
import 'package:conciseparser/parser/letter.dart';
import 'package:conciseparser/runner.dart';
import 'package:test/test.dart';

void main() {
  test('letter', () {
    var grammar = StringParser(letter);
    expect(
      parseOrThrow("x", grammar), 
      "x");
  });

  test('letters', () {
    var grammar = StringParser(letter * 3);
    expect(
      parseOrThrow("xyz", grammar), 
      "xyz");
  });

  test('capitalLetters', () {
    var grammar = StringParser(letter * 3);
    expect(
      parseOrThrow("XYZ", grammar), 
      "XYZ");
  });

  test('lettersFail', () {
    var grammar = StringParser(letter * 3);
    expect(
      () => parseOrThrow("ab", grammar), 
      throwsA((e) => e is ParseException));
  });

  test('letterFail', () {
    var grammar = StringParser(letter);
    expect(
      () => parseOrThrow("1", grammar), 
      throwsA((e) => e is ParseException));
  });
}
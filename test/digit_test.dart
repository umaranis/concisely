import 'package:conciseparser/continuation/string.dart';
import 'package:conciseparser/exception.dart';
import 'package:conciseparser/parser/char/digit.dart';
import 'package:conciseparser/runner.dart';
import 'package:test/test.dart';

void main() {
  test('digit', () {
    var grammar = StringParser(digit);
    expect(
      parseOrThrow("1", grammar), 
      "1");
  });

  test('digits', () {
    var grammar = StringParser(digit * 3);
    expect(
      parseOrThrow("123", grammar), 
      "123");
  });

  test('digitsFail', () {
    var grammar = StringParser(digit * 3);
    expect(
      () => parseOrThrow("12", grammar), 
      throwsA((e) => e is ParseException));
  });

  test('digitFail', () {
    var grammar = StringParser(digit);
    expect(
      () => parseOrThrow("A", grammar), 
      throwsA((e) => e is ParseException));
  });
}
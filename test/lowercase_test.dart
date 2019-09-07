import 'package:concisely/continuation/string.dart';
import 'package:concisely/exception.dart';
import 'package:concisely/parser/char/lowercase.dart';
import 'package:concisely/runner.dart';
import 'package:test/test.dart';

void main() {
  test('lowercase', () {
    var grammar = StringParser(lowercase);
    expect(
      parseOrThrow("x", grammar), 
      "x");
  });

  test('lowercase letters', () {
    var grammar = StringParser(lowercase * 3);
    expect(
      parseOrThrow("xyz", grammar), 
      "xyz");
  });

  test('lowercase fail', () {
    var grammar = StringParser(lowercase);
    expect(
      () => parseOrThrow("A", grammar), 
      throwsA((e) => e is ParseException));
  });
  
}
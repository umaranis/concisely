import 'package:concisely/continuation/string.dart';
import 'package:concisely/exception.dart';
import 'package:concisely/parser/char/uppercase.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() {
  test('uppercase', () {
    var grammar = StringParser(uppercase);
    expect(
      parseOrThrow("X", grammar), 
      "X");
  });

  test('uppercase letters', () {
    var grammar = StringParser(uppercase * 3);
    expect(
      parseOrThrow("XYZ", grammar), 
      "XYZ");
  });

  test('uppercase fail', () {
    var grammar = StringParser(uppercase);
    expect(
      () => parseOrThrow("a", grammar), 
      throwsA((e) => e is ParseException));
  });
  
}
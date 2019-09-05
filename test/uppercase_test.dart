import 'package:conciseparser/continuation/string.dart';
import 'package:conciseparser/exception.dart';
import 'package:conciseparser/parser/uppercase.dart';
import 'package:conciseparser/runner.dart';
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
import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/lowercase.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() {
  test('lowercase', () {
    var grammar = lowercase > string;
    expect(
      parseOrThrow("x", grammar), 
      "x");
  });

  test('lowercase letters', () {
    var grammar = lowercase * 3 > string;
    expect(
      parseOrThrow("xyz", grammar), 
      "xyz");
  });

  test('lowercase fail', () {
    var grammar = lowercase > string;
    expect(
      () => parseOrThrow("A", grammar), 
      throwsA((e) => e is ParseException));
  });
  
}
import 'package:concisely/continuation/string.dart';
import 'package:concisely/exception.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/runner.dart';
import 'package:test/test.dart';

void main() {
  test('space', () {
    var grammar = StringParser(whitespace);
    expect(
      parseOrThrow(" ", grammar), 
      " ");
  });

  test('spaces', () {
    var grammar = StringParser(whitespace * 3);
    expect(
      parseOrThrow("   ", grammar), 
      "   ");
  });

  test('newline', () {
    var grammar = StringParser(whitespace * 3);
    expect(
      parseOrThrow("\n\n\n", grammar), 
      "\n\n\n");
  });

  test('carriageReturn', () {
    var grammar = StringParser(whitespace);
    expect(
      parseOrThrow("\r", grammar), 
      "\r");
  });

  test('carriageReturn', () {
    var grammar = StringParser(whitespace & whitespace);
    expect(
      parseOrThrow("\r\n", grammar), 
      "\r\n");
  });

  test('newlineTab', () {
    var grammar = StringParser(whitespace * 2);
    expect(
      parseOrThrow("\t\n", grammar), 
      "\t\n");
  });

  test('tab', () {
    var grammar = StringParser(whitespace);
    expect(
      parseOrThrow("\t", grammar), 
      "\t");
  });

  test('whitespaceFail', () {
    var grammar = StringParser(whitespace);
    expect(
      () => parseOrThrow("a", grammar), 
      throwsA((e) => e is ParseException));
  });  
}
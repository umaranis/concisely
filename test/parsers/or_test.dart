
import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() { 

  test('orParser', () {
    var grammar = (char("A") * 5 | char("G") * 5) & (char("G") | char("K")) > string;
    expect(
      parseOrThrow("AAAAAG", grammar), 
      "AAAAAG");
  });

  test('orParserError', () {
    var grammar = (char("F") * 5 | char("G") * 5) & (char("G") | char("G")) > string;
    expect(
      () => parseOrThrow("AAAAAGG", grammar)
        .reduce((a, b) => a + b), 
      throwsA((e) => e is ParseException));
  });
}
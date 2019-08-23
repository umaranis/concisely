import 'package:dallang/char.dart';
import 'package:dallang/continuation/string.dart';
import 'package:dallang/exception.dart';
import 'package:dallang/runner.dart';
import 'package:test/test.dart';

void main() { 

  test('orParser', () {
    var grammar = StringParser((char("A") * 5 | char("G") * 5) & (char("G") | char("K")));
    expect(
      parseOrThrow("AAAAAGG", grammar), 
      "AAAAAG");
  });

  test('orParserError', () {
    var grammar = StringParser(char("F") * 5 | char("G") * 5) & (char("G") | char("G"));
    expect(
      () => parseOrThrow("AAAAAGG", grammar)
        .reduce((a, b) => a + b), 
      throwsA((e) => e is ParseException));
  });
}
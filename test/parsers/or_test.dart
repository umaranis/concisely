import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() { 

  test('orParser', () {
    var grammar = (char('A') * 5 | char('G') * 5) & (char('G') | char('K')) > toStr;
    expect(
      parseOrThrow('AAAAAG', grammar),
      'AAAAAG');
  });

  test('orParserError', () {
    var grammar = (char('F') * 5 | char('G') * 5) & (char('G') | char('G')) > toStr;
    expect(
      () => parseOrThrow('AAAAAGG', grammar)
        .reduce((a, b) => a + b), 
      throwsA((e) => e is ParseException));
  });
}
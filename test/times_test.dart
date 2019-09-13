import 'package:concisely/continuation/string.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/runner.dart';
import 'package:concisely/times/times.dart';
import 'package:test/test.dart';

void main() {
  test('optional', () {
    var grammar = StringParser(char("A") * 5 & char("G") * 2) * optional;    
    expect(
      parseOrThrow("AAAAAGF", grammar), 
      null);
  });

  test('7times', () {
    var grammar = StringParser( (char('A') | char('\n')) * 7 );            
    expect(
      parseOrThrow("AAA\nAA\nAA", grammar), 
      "AAA\nAA\n");
  });

  test('times_list', () {
    var grammar = char('A') * 3;            
    expect(
      parseOrThrow("AAA", grammar), 
      "AAA");
  });
}
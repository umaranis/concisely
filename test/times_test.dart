import 'package:conciseparser/char.dart';
import 'package:conciseparser/continuation/string.dart';
import 'package:conciseparser/runner.dart';
import 'package:conciseparser/times.dart/times.dart';
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
}
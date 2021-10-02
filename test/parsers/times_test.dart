
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() {

  test('7times', () {
    var grammar =  (char('A') | char('\n')) * 7   > string;            
    expect(
      parseOrThrow("AAA\nAA\n", grammar), 
      "AAA\nAA\n");
  });

  test('times_list', () {
    var grammar = char('A') * 3;            
    expect(
      parseOrThrow("AAA", grammar), 
      ['A','A','A']);
  });
}
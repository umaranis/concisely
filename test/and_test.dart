import 'package:concisely/continuation/string.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/runner.dart';
import 'package:test/test.dart';

void main() {
  test('andParser', () {
    var grammar = StringParser(char("A") * 5 & char("G") * 2);
    expect(
      parseOrThrow("AAAAAGG", grammar), 
      "AAAAAGG");
  });
}
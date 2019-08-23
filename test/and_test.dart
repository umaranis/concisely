import 'package:dallang/char.dart';
import 'package:dallang/continuation/string.dart';
import 'package:dallang/runner.dart';
import 'package:test/test.dart';

void main() {
  test('andParser', () {
    var grammar = StringParser(char("A") * 5 & char("G") * 2);
    expect(
      parseOrThrow("AAAAAGG", grammar), 
      "AAAAAGG");
  });
}
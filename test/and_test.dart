import 'package:concisely/continuation/string.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  test('andParser', () {
    var grammar = StringParser(char("A") * 5 & char("G") * 2);
    expect(
      parseOrThrow("AAAAAGG", grammar), 
      "AAAAAGG");
  });

  test('andParser 2', () {
    var grammar = StringParser(char("A") * 5 & char("G") * 2);
    expectSuccess(
      parse("AAAAAGG", grammar), 
      "AAAAAGG");
  });
}
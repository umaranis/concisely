import 'package:conciseparser/char.dart';
import 'package:conciseparser/continuation/string.dart';
import 'package:conciseparser/runner.dart';
import 'package:test/test.dart';

void main() {
  test('andParser', () {
    var grammar = StringParser(char("A") * 5 & char("G") * 2);
    expect(
      parseOrThrow("AAAAAGG", grammar), 
      "AAAAAGG");
  });
}
import 'package:conciseparser/parser/char/newline.dart';
import 'package:conciseparser/runner.dart';
import 'package:test/test.dart';

void main() {
  test('newline', () {
    var grammar = newline * 3;
    expect(
      parseOrThrow("\n\r\n\n", grammar).length, 
      3);
  });

  test('newline result', () {
    final grammar = newline * 3;
    final result = parseOrThrow("\n\r\n\n", grammar);
    expect(result, ['\n',['\r','\n'],'\n']);
  });
}
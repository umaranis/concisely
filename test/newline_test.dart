import 'package:concisely/parser/char/newline.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {  

  test('newline 2', () {
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

  test('newline failure', () {
    final grammar = newline * 2;
    expectFailure(
      parse("\n2", grammar),
      "\\n"
    );
  });
}
import 'package:dallang/char.dart';
import 'package:dallang/dallang.dart';
import 'package:dallang/exception.dart';
import 'package:dallang/runner.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });

  test('parseChar', () {
    expect(
      parseOrThrow("@ASSA#", char("@")), 
      "@");
  });

  test('parse2Chars', () {
    expect(
      parseOrThrow("9988", char("9") & char("9"))
        .reduce((a, b) => a + b), 
      "99");
  });

  test('times', () {
    var grammar = char("A") * 5;
    expect(
      parseOrThrow("AAAAA", grammar)
        .reduce((a, b) => a + b), 
      "AAAAA");
  });

  test('times_error_message', () {
    expect(
      () => parseOrThrow("AAAA", char("A") * 5), 
      throwsA((e) => e is ParseException && e.result.message == '"A" expected'));
  });

  test('times_error_toString', () {
    expect(
      () => parseOrThrow("AAA", char("A") * 5), 
      throwsA((e) => e is ParseException && e.result.toString() == 'Failure[line:1, col:4] "A" expected'));
  });

  test('parseCharsTimes', () {     
      var grammar = char("9") * 2 & char("8") * 2;       
      List<dynamic> r = parseOrThrow("9988", grammar);

      expect(
        r.reduce((a, b) => a + b).reduce((a, b) => a + b), 
        "9988");
  });
}

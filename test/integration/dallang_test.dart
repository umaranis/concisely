import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() { 

  test('parseChar', () {
    expect(
      parseOrThrow('@', char('@')),
      '@');
  });

  test('parse2Chars', () {
    expect(
      parseOrThrow('99', char('9') & char('9') > toStr),
      '99');
  });

  test('times', () {
    var grammar = char('A') * 5;
    expect(
      parseOrThrow('AAAAA', grammar),
      ['A', 'A', 'A', 'A', 'A']);
  });

  test('times error message', () {
    expect(
      () => parseOrThrow('AAAA', char('A') * 5),
      throwsA((e) => e is ParseException && e.result.message == '"A" expected'));
  });

  test('times_error_toString', () {
    expect(
      () => parseOrThrow('AAA', char('A') * 5),
      throwsA((e) => e is ParseException && e.result.toString() == 'Failure[pos:4] "A" expected'));
  });

  test('parseCharsTimes', () {     
      var grammar = char('9') * 2 & char('8') * 2 > toStr;
      final r = parseOrThrow('9988', grammar);

      expect(
        r, 
        '9988');
  });
}

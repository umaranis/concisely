import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() {
  test('uppercase', () {
    var grammar = uppercase > toStr;
    expect(
      parseOrThrow('X', grammar),
      'X');
  });

  test('uppercase letters', () {
    var grammar = uppercase * 3 > toStr;
    expect(
      parseOrThrow('XYZ', grammar),
      'XYZ');
  });

  test('uppercase fail', () {
    var grammar = uppercase > toStr;
    expect(
      () => parseOrThrow('a', grammar),
      throwsA((e) => e is ParseException));
  });
  
}
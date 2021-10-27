import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() {
  test('lowercase', () {
    var grammar = lowercase > toStr;
    expect(
      parseOrThrow('x', grammar),
      'x');
  });

  test('lowercase letters', () {
    var grammar = lowercase * 3 > toStr;
    expect(
      parseOrThrow('xyz', grammar),
      'xyz');
  });

  test('lowercase fail', () {
    var grammar = lowercase > toStr;
    expect(
      () => parseOrThrow('A', grammar),
      throwsA((e) => e is ParseException));
  });
  
}
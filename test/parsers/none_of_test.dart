import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart';

void main() {
  test('noneOf', () {
    var grammar = noneOf('"/') > toStr;

    expect(parseOrThrow('1', grammar),
        '1');
  });

  test('noneOf fail', () {
    var grammar = noneOf('"/') > toStr;

    expect(
        () => parseOrThrow('"', grammar),
        throwsA((e) => e is ParseException));
  });

  test('noneOf escape character', () {
    var grammar = noneOf(r'"\') > toStr; // r is for raw string

    expect(parseOrThrow('abc', grammar),
        'a');
  });

  test('noneOf escape character', () {
    var grammar = noneOf(r'"\') > toStr; // r is for raw string

    expect(
        () => parseOrThrow('"', grammar),
        throwsA((e) => e is ParseException));
  });

  test('noneOf * many', () {
    var grammar = noneOf(r'"\') * many > toStr; // r is for raw string

    expect(parseOrThrow(r'how are you?\nI am fine.', grammar),
        r'how are you?' );
  });

  test('noneOf * many', () {
    var grammar = noneOf(r'"\') * many > toStr; // r is for raw string

    expect(parseOrThrow(r'how are you? " I am fine.', grammar),
        r'how are you? ' );
  });
}

import 'package:concisely/concisely.dart';
import 'package:concisely/src/exception.dart';
import 'package:test/test.dart' hide anyOf;

void main() {
  test('anyOf 1st char', () {
    var grammar = anyOf('"/') > toStr;

    expect(parseOrThrow('"', grammar),
        '"');
  });

  test('anyOf 2nd char', () {
    var grammar = anyOf('"/') > toStr;

    expect(parseOrThrow('/', grammar),
        '/');
  });

  test('anyOf fail', () {
    var grammar = anyOf('"/') > toStr;

    expect(
        () => parseOrThrow('1', grammar),
        throwsA((e) => e is ParseException));
  });

  test('anyOf * many', () {
    var grammar = anyOf(r'"abc\ ') * many > toStr; // r is for raw string

    expect(parseOrThrow(r'abc bca cca\ "I am fine.', grammar),
        r'abc bca cca\ "' );
  });

}

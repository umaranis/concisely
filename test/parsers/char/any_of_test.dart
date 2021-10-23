import 'package:concisely/exception.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:concisely/parser/char/any_of.dart';
import 'package:test/test.dart' hide anyOf;

void main() {
  test('anyOf 1st char', () {
    var grammar = anyOf('"/') > type.string;

    expect(parseOrThrow('"', grammar),
        '"');
  });

  test('anyOf 2nd char', () {
    var grammar = anyOf('"/') > type.string;

    expect(parseOrThrow('/', grammar),
        '/');
  });

  test('anyOf fail', () {
    var grammar = anyOf('"/') > type.string;

    expect(
        () => parseOrThrow('1', grammar),
        throwsA((e) => e is ParseException));
  });

  test('anyOf * many', () {
    var grammar = anyOf(r'"abc\ ') * many > type.string; // r is for raw string

    expect(parseOrThrow(r'abc bca cca\ "I am fine.', grammar),
        r'abc bca cca\ "' );
  });

}

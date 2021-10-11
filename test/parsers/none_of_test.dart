import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/none_of.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

void main() {
  test('noneOf', () {
    var grammar = noneOf('"/') > type.string;

    expect(parseOrThrow('1', grammar),
        '1');
  });

  test('noneOf fail', () {
    var grammar = noneOf('"/') > type.string;

    expect(
        () => parseOrThrow('"', grammar),
        throwsA((e) => e is ParseException));
  });

  test('noneOf escape character', () {
    var grammar = noneOf(r'"\') > type.string; // r is for raw string

    expect(parseOrThrow('abc', grammar),
        'a');
  });

  test('noneOf escape character', () {
    var grammar = noneOf(r'"\') > type.string; // r is for raw string

    expect(
        () => parseOrThrow('"', grammar),
        throwsA((e) => e is ParseException));
  });

  test('noneOf * many', () {
    var grammar = noneOf(r'"\') * many > type.string; // r is for raw string

    expect(parseOrThrow(r'how are you?\nI am fine.', grammar),
        r'how are you?' );
  });

  test('noneOf * many', () {
    var grammar = noneOf(r'"\') * many > type.string; // r is for raw string

    expect(parseOrThrow(r'how are you? " I am fine.', grammar),
        r'how are you? ' );
  });
}

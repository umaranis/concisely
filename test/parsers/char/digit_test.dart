
import 'package:concisely/exception.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

void main() {
  test('digit', () {
    var grammar = digit > type.string;
    expect(
      parseOrThrow('1', grammar),
      '1');
  });

  test('digits', () {
    var grammar = digit * 3 > type.string;
    expect(
      parseOrThrow('123', grammar),
      '123');
  });

  test('digitsFail', () {
    var grammar = digit * 3 > type.string;
    expect(
      () => parseOrThrow('12', grammar),
      throwsA((e) => e is ParseException));
  });

  test('digitFail', () {
    var grammar = digit > type.string;
    expect(
      () => parseOrThrow('A', grammar),
      throwsA((e) => e is ParseException));
  });
}
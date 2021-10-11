import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/lowercase.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

void main() {
  test('lowercase', () {
    var grammar = lowercase > type.string;
    expect(
      parseOrThrow('x', grammar),
      'x');
  });

  test('lowercase letters', () {
    var grammar = lowercase * 3 > type.string;
    expect(
      parseOrThrow('xyz', grammar),
      'xyz');
  });

  test('lowercase fail', () {
    var grammar = lowercase > type.string;
    expect(
      () => parseOrThrow('A', grammar),
      throwsA((e) => e is ParseException));
  });
  
}
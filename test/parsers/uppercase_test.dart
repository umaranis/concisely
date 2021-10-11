import 'package:concisely/exception.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/uppercase.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

void main() {
  test('uppercase', () {
    var grammar = uppercase > type.string;
    expect(
      parseOrThrow('X', grammar),
      'X');
  });

  test('uppercase letters', () {
    var grammar = uppercase * 3 > type.string;
    expect(
      parseOrThrow('XYZ', grammar),
      'XYZ');
  });

  test('uppercase fail', () {
    var grammar = uppercase > type.string;
    expect(
      () => parseOrThrow('a', grammar),
      throwsA((e) => e is ParseException));
  });
  
}
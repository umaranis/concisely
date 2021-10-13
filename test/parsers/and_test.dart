import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {
  test('andParser', () {
    var grammar = char('A') * 5 & char('G') * 2 > type.string;
    expect(
      parseOrThrow('AAAAAGG', grammar),
      'AAAAAGG');
  });

  test('andParser 2', () {
    var grammar = char('A') * 5 & char('G') * 2 > type.string;
    expectSuccess(
      parse('AAAAAGG', grammar),
      'AAAAAGG');
  });
}
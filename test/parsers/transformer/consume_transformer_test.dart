import 'package:concisely/parser/transformer/consume_transformer.dart';
import 'package:concisely/parser/transformer/skip_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/combiner/reference.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {
  group('number in multiple brackets', () {
    int value = 0;
    final number = ref;
    number.p = (digit.many > type.string.consume((r) => value = int.parse(r)))  |  char('(') & number & char(')');

    test('number', () {
      expectParse.pass(number,
          '123',
          blank);
      expect(value, 123);
    });

    test('number in brackets', () {
      expectParse.pass(number > type.string,
          '(12)',
          '()');
      expect(value, 12);
    });

    test('number in brackets (result in list)', () {
      expectParse.pass(number > type.list,
          '(12)',
          ['(',')']);
      expect(value, 12);
    });

    test('number in many brackets', () {
      expectParse.pass(number > type.list,
          '(((12)))',
          ['(', '(', '(', ')', ')', ')']);
      expect(value, 12);
    });

    test('brackets mismatch', () {
      expectParse.fail(number, '(((12))');
    });

  });

}

import 'package:concisely/concisely.dart';
import 'package:concisely/src/parser/transformer/consume_transformer.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {
  group('number in multiple brackets', () {
    int value = 0;
    final number = ref;
    number.p = (digit.many > toStr.consume((r) => value = int.parse(r)))  |  char('(') & number & char(')');

    test('number', () {
      expectParse.pass(number,
          '123',
          blank);
      expect(value, 123);
    });

    test('number in brackets', () {
      expectParse.pass(number > toStr,
          '(12)',
          '()');
      expect(value, 12);
    });

    test('number in brackets (result in list)', () {
      expectParse.pass(number > toList,
          '(12)',
          ['(',')']);
      expect(value, 12);
    });

    test('number in many brackets', () {
      expectParse.pass(number > toList,
          '(((12)))',
          ['(', '(', '(', ')', ')', ')']);
      expect(value, 12);
    });

    test('brackets mismatch', () {
      expectParse.fail(number, '(((12))');
    });

  });

}

import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/combiner/reference.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {
  group('number in multiple brackets', () {
    final number = ref;
    number.p = (digit.many > type.string.map((r) => int.parse(r)))  |  char('(') & number & char(')');

    test('number', () {
      expectParse.pass(number,
          '123',
          123);
    });

    test('number in brackets', () {
      expectParse.pass(number > type.string,
          '(12)',
          '(12)');
    });

    test('number in brackets (result in list)', () {
      expectParse.pass(number > type.list,
          '(12)',
          ['(',12 ,')']);
    });

    test('number in many brackets', () {
      expectParse.pass(number > type.list,
          '(((12)))',
          ['(', '(', '(', 12, ')', ')', ')']);
    });

    test('brackets mismatch', () {
      expectParse.fail(number, '(((12))');
    });

  });

  group('expression', () {
    final term = ref, prod = ref, prim = ref, add = ref, mul = ref, parens = ref, number = ref;

    add.p     = prod & char('+') & term > map((r) => r[0] + r[2]);
    term.p    = add | prod;
    mul.p     = prim & char('*') & prod > map((r) => r[0] * r[2]);
    prod.p    = mul | prim;
    parens.p  = char('(') & term & char(')') > map((r) => r[1]);
    number.p  = digit.many > type.string.map((r) => int.parse(r));
    prim.p    = parens | number;

    final start = term & eof > map((r) => r[0]);

    test('1+2*3', () {
      expectParse.pass(start,
          '1+2*3',
          7
      );
    });

    test('(1+2)*3', () {
      expectParse.pass(start,
          '(1+2)*3',
          9
      );
    });

  });

}

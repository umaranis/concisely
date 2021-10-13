import 'package:concisely/executor.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/combiner/reference.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

import '../../helper.dart';

void main() {
  group('convert to integer', () {
    final number = ref;
    number.p = (digit.many > type.int)  |  char('(') & number & char(')');

    test('number', () {
      expectParse(number,
          '123',
          123);
    });

    test('decimal', () {
      expectParse(number,
          '123.45',
          123);
    });

    test('decimal fail', () {
      expectFailure(parse('123.45', number & eof));
    });

    test('number in many brackets', () {
      expectParse(number > type.list,
          '(((12)))',
          ['(', '(', '(', 12, ')', ')', ')']);
    });

    test('brackets mismatch', () {
      expectFailure(parse('(((12))', number));
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
      expectParse(start,
          '1+2*3',
          7
      );
    });

    test('(1+2)*3', () {
      expectParse(start,
          '(1+2)*3',
          9
      );
    });

  });

}

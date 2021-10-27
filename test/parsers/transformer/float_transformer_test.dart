import 'package:concisely/concisely.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {
  group('convert to float', () {
    final number = ref;
    number.p = (digit.many & (char('.') & digit.many).optional > toFloat)  |  char('(') & number & char(')');

    test('integer', () {
      expectParse.pass(number,
          '123',
          123);
    });

    test('decimal', () {
      expectParse.pass(number,
          '123.45',
          123.45);
    });

    test('decimal fail', () {
      expectParse.fail(number & eof, '123.4.5');
    });

    test('number in many brackets', () {
      expectParse.pass(number > toList,
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
    number.p  = digit.many & (char('.') & digit.many).optional > toFloat;
    prim.p    = parens | number;

    final start = term & eof > map((r) => r[0]);

    test('1.2+2*3', () {
      expectParse.pass(start,
          '1.2+2*3',
          7.2
      );
    });

    test('(1+2)*3', () {
      expectParse.pass(start,
          '(1.2+2)*3',
          9.600000000000001
      );
    });

  });

}

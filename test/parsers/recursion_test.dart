import 'package:concisely/debug/trace.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/parser/combiner/reference.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {
  group('number in multiple brackets', () {
    final number = ref();
    number.p = digit.many | char('(') & number & char(')');

    test('number', () {
      expectParse(number,
          '123',
          ['1','2','3']);
    });

    test('number in brackets', () {
      expectParse(number,
          '(12)',
          ['(',['1','2'],')']);
    });

    test('number in brackets (result in list)', () {
      expectParse(number > list,
          '(12)',
          ['(','1','2',')']);
    });

    test('number in many brackets', () {
      expectParse(number > list,
          '(((12)))',
          ['(', '(', '(', '1', '2', ')', ')', ')']);
    });

    test('brackets mismatch', () {
      expectFailure(parse('(((12))', number));
    });

  });
  
  group('expression', () {
    final term = ref(), prod = ref(), prim = ref(), add = ref(), mul = ref(), parens = ref(), number = ref();

    add.p = prod & char('+') & term;
    term.p = add | prod;
    mul.p = prim & char('*') & prod;
    prod.p = mul | prim;
    parens.p = char('(') & term & char(')');
    number.p = digit.many;
    prim.p = parens | number;

    final start = term & eof;

    test('1+2*3', () {
      expectParse(start,
          '1+2*3',
          [[['1'], '+', [['2'], '*', ['3']]]]
      );
    });

    test('(1+2)*3', () {
      expectParse(start,
          '(1+2)*3',
          [[['(', [['1'], '+', ['2']], ')'], '*', ['3']]]
      );
    });

  });

}

import 'package:concisely/executor.dart';
import 'package:concisely/parser/transformer/pick_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/combiner/reference.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';

void main() {
  group('number in brackets', () {
    final number = digit.many > type.int;
    final grammar = char('(') & number & char(')');

    test('pick number', () {
      expectParse.pass(grammar > pick(1),
          '(123)',
          123);
    });

    test('pick brackets', () {
      expectParse.pass(grammar > pick(0,2),
          '(123)',
          ['(',')']);
    });

    test('pick twice', () {
      expectParse.pass((grammar > pick(0,1)) > pick(1),
          '(12)',
          12);
    });

    test('pick failure', () {
      expectParse.fail((grammar > pick(1)) > pick(0),
          '(12)',
          "pick(0) failed because '12' is not a list");
    });

  });

  group('expression', () {
    final term = ref, prod = ref, prim = ref, add = ref, mul = ref, parens = ref, number = ref;

    add.p     = prod & char('+') & term > pick(0, 2).map((r) => r[0] + r[1]);
    term.p    = add | prod;
    mul.p     = prim & char('*') & prod > pick(0, 2).map((r) => r[0] * r[1]);
    prod.p    = mul | prim;
    parens.p  = char('(') & term & char(')') > pick(1);
    number.p  = digit.many > type.int;
    prim.p    = parens | number;

    final start = term & eof > pick(0);

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

  test('pick failure', () {
    var grammar = char('0') & char('1') & char('2') & char('3') & char('4') & char('5') &
        char('6') & char('7') & char('8') & char('9') & char('0') & char('1') & char('2')
        > pick(1,2,3,4,6,6,8,9,10,11);
    expectParse.pass(grammar,
        '0123456789012',
        ['1', '2', '3', '4', '6', '8', '9', '0', '1']);
  });

}

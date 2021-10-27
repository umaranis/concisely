import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {
  group('convert to integer', () {
    final expression = ref;
    final number = digit.many > toInt;
    final bracket = char('(') + expression + char(')');
    expression.p = number  |  bracket;

    test('number', () {
      expectParse.pass(expression,
          '123',
          123);
    });

    test('number with whitespaces', () {
      expectParse.pass(expression.trim,
          ' 123  ',
          123);
    });

    test('number in brackets', () {
      expectParse.pass(expression,
          '(123)',
          ['(', 123, ')']);
    });

    test('number in brackets with spaces', () {
      expectParse.pass(expression,
          '( 123 )',
          ['(', 123, ')']);
    });

    test('number in many brackets', () {
      expectParse.pass(expression > toList,
          '(( ( 12 )) )',
          ['(', '(', '(', 12, ')', ')', ')']);
    });

    test('brackets mismatch', () {
      expectParse.fail(expression, '(((12))');
    });

  });

  group('expression', () {
    final term = ref, prod = ref, prim = ref, add = ref, mul = ref, parens = ref, number = ref;

    add.p     = prod + char('+') + term;
    term.p    = add | prod;
    mul.p     = prim + char('*') + prod;
    prod.p    = mul | prim;
    parens.p  = char('(') + term + char(')') > pick(1);
    number.p  = digit.many > toInt;
    prim.p    = parens | number;

    final start = term.trim + eof > pick(0);

    test('1+2*3', () {
      expectParse.pass(start,
          '1+2*3',
          [1, '+', [2, '*', 3]]
      );
    });

    test('1 + 2 * 3', () {
      expectParse.pass(start,
          '1 + 2 * 3',
          [1, '+', [2, '*', 3]]
      );
    });

    test('(1+2)*3', () {
      expectParse.pass(start,
          '(1+2)*3',
          [[1, '+', 2], '*', 3]
      );
    });

    test('( 1 + 2 ) * 3', () {
      expectParse.pass(start,
          '( 1 + 2 ) * 3',
          [[1, '+', 2], '*', 3]
      );
    });

    test('( 1 + 2 ) * 3 ', () {
      expectParse.pass(start,
          '( 1 + 2 ) * 3 ',
          [[1, '+', 2], '*', 3]
      );
    });

    test(' ( 1 + 2 ) * 3 ', () {
      expectParse.pass(start,
          ' ( 1 + 2 ) * 3 ',
          [[1, '+', 2], '*', 3]
      );
    });

  });

}

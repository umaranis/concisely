import 'package:concisely/src/parser/char/char.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {
  group('char pattern', () {
    test('range A', () {
      expectParse.pass(char('A-Z'),
          'A',
          'A');
    });

    test('range S', () {
      expectParse.pass(char('A-Z'),
          'S',
          'S');
    });

    test('range Z', () {
      expectParse.pass(char('A-Z'),
          'Z',
          'Z');
    });

    test('range fail', () {
      expectParse.fail(char('A-Y'),
          'Z');
    });

    test('range number', () {
      expectParse.pass(char('1-9'),
          '1',
          '1');
    });
  });

  group('multiple ranges and characters', () {

    test('range and a char 1', () {
      expectParse.pass(char('1-9.'),
          '1',
          '1');
    });

    test('range and a char .', () {
      expectParse.pass(char('1-9.'),
          '.',
          '.');
    });

    test('mixed bag 2', () {
      expectParse.pass(char('1-9.A-C=+'),
          '2',
          '2');
    });

    test('mixed bag .', () {
      expectParse.pass(char('1-9.A-C=+'),
          '.',
          '.');
    });

    test('mixed bag B', () {
      expectParse.pass(char('1-9.A-C=+'),
          'B',
          'B');
    });

    test('mixed bag +', () {
      expectParse.pass(char('1-9.A-C=+'),
          '+',
          '+');
    });

    test('mixed bag #', () {
      expectParse.fail(char('1-9.A-C=+'),
          '#');
    });

    test('mixed bag -', () {
      expectParse.pass(char('-1-9.A-C=+'),
          '-',
          '-');
    });

    test('mixed bag - fail', () {
      expectParse.fail(char('1-9.A-C=+'),
          '-');
    });

  });
}
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/repeater/separated_by.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {

  test('separated by ,', () {
    var grammar =  char('A').separatedBy(',');
    expectParse.pass(grammar,
        'A,A,A',
        ['A','A','A']);
  });

  test('type.string', () {
    var grammar =  char('A').separatedBy(',') > type.string;
    expectParse.pass(grammar,
        'A,A,A',
        'AAA');
  });

  test('trim spaces', () {
    var grammar =  char('A').separatedBy(',') & eof > type.string;
    expectParse.pass(grammar,
        'A , A ,   A',
        'AAA');
  });

  test('include separator at end', () {
    var grammar =  char('A').separatedBy(',', true) & eof > type.string;
    expectParse.pass(grammar,
        'A , A ,   A,',
        'AAA');
  });

  test('multi character separator', () {
    var grammar =  char('A').separatedBy('--', true) & eof > type.string;
    expectParse.pass(grammar,
        'A -- A --   A--',
        'AAA');
  });

  test('parser as separator', () {
    var grammar =  char('A').separatedBy(char('.').many, true) & eof > type.string;
    expectParse.pass(grammar,
        'A .. A ...   A ..',
        'AAA');
  });
}
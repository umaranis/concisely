import 'package:concisely/debug/trace.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/repeater/separated_by.dart';
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

  test('separated by , > type.string', () {
    var grammar =  char('A').separatedBy(',') > type.string;
    expectParse.pass(grammar,
        'A,A,A',
        'AAA');
  });

  test('separated by, trim spaces', () {
    var grammar =  char('A').separatedBy(',') & eof > type.string;
    expectParse.pass(grammar,
        'A , A ,   A',
        'AAA');
  });

  test('times list', () {
    var grammar = char('A') * 3;
    expectParse.pass(grammar,
        'AAA',
        ['A','A','A']);
  });
}
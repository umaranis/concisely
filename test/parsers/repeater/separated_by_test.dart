import 'package:concisely/concisely.dart';
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
    var grammar =  char('A').separatedBy(',') > toStr;
    expectParse.pass(grammar,
        'A,A,A',
        'AAA');
  });

  test('trim spaces', () {
    var grammar =  char('A').separatedBy(',') & eof > toStr;
    expectParse.pass(grammar,
        'A , A ,   A',
        'AAA');
  });

  test('include separator at end', () {
    var grammar =  char('A').separatedBy(',', true) & eof > toStr;
    expectParse.pass(grammar,
        'A , A ,   A,',
        'AAA');
  });

  test('multi character separator', () {
    var grammar =  char('A').separatedBy('--', true) & eof > toStr;
    expectParse.pass(grammar,
        'A -- A --   A--',
        'AAA');
  });

  test('parser as separator', () {
    var grammar =  char('A').separatedBy(char('.').many, true) & eof > toStr;
    expectParse.pass(grammar,
        'A .. A ...   A ..',
        'AAA');
  });
}
import 'package:concisely/parser/char/any_of.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/except.dart';
import 'package:concisely/parser/char/none_of.dart';
import 'package:concisely/parser/char/range.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {
  test('single char', () {
    expectParse.equalGrammar(except('1'), NotCharParser('1'));
  });

  test('-', () {
    expectParse.equalGrammar(except('-'), NotCharParser('-'));
  });

  test('- 1234', () {
    expectParse.equalGrammar(except('- 1234'), NoneOfParser('- 1234'));
  });

  test('two chars', () {
    expectParse.equalGrammar(except('12'), NoneOfParser('12'));
  });

  test('range', () {
    expectParse.equalGrammar(except('1-5'), NotCharRangeParser('1', '5'));
  });

  test('mixed', () {
    expectParse.equalGrammar(except('1-56789'), NotCharRangeParser('1', '5') | NoneOfParser('6789'));
  });

  test('mixed 2', () {
    expectParse.equalGrammar(except('67891-5'), NotCharRangeParser('1', '5') | NoneOfParser('6789'));
  });

  test('mixed 2', () {
    expectParse.equalGrammar(except('1-5AB6-9'), NotCharRangeParser('1', '5') | NotCharRangeParser('6', '9') | NoneOfParser('AB'));
  });

  test('two ranges', () {
    expectParse.equalGrammar(except('1-56-9'), NotCharRangeParser('1', '5') | NotCharRangeParser('6', '9'));
  });


}
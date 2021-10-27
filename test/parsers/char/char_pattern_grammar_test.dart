import 'package:concisely/src/parser/char/any_of.dart';
import 'package:concisely/src/parser/char/char.dart';
import 'package:concisely/src/parser/char/range.dart';
import 'package:test/test.dart';
import '../../expect_parse_helper.dart';

void main() {
  test('single char', () {
    expectParse.equalGrammar(char('1'), CharParser('1'));
  });

  test('-', () {
    expectParse.equalGrammar(char('-'), CharParser('-'));
  });

  test('- 1234', () {
    expectParse.equalGrammar(char('- 1234'), AnyOfParser('- 1234'));
  });

  test('two chars', () {
    expectParse.equalGrammar(char('12'), AnyOfParser('12'));
  });

  test('range', () {
    expectParse.equalGrammar(char('1-5'), CharRangeParser('1', '5'));
  });

  test('mixed', () {
    expectParse.equalGrammar(char('1-56789'), CharRangeParser('1', '5') | AnyOfParser('6789'));
  });

  test('mixed 2', () {
    expectParse.equalGrammar(char('67891-5'), CharRangeParser('1', '5') | AnyOfParser('6789'));
  });

  test('mixed 2', () {
    expectParse.equalGrammar(char('1-5AB6-9'), CharRangeParser('1', '5') | CharRangeParser('6', '9') | AnyOfParser('AB'));
  });

  test('two ranges', () {
    expectParse.equalGrammar(char('1-56-9'), CharRangeParser('1', '5') | CharRangeParser('6', '9'));
  });


}
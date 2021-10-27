import 'package:concisely/concisely.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:test/test.dart';
import '../helper.dart';

void main() {
  test('eof', () {
    var grammar = digit & eof;
    expectSuccess(
      parse("1", grammar), 
      ["1"]);
  });

  test('eof fail', () {
    var grammar = digit & eof;
    expectFailure(
      parse("12", grammar), 
      "End of File expected");
  });

  test('eof empty string', () {
    var grammar = eof;
    expectSuccess(
      parse("", grammar), 
      blank);
  });

  test('eof fast parse', () {
    expect(
      eof.fastParse(Context("", 0), 0), 
      0);
  });
}
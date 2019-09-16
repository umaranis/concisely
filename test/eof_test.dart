import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:test/test.dart';
import 'helper.dart';

void main() {
  test('eof', () {
    var grammar = digit & eof;
    expectSuccess(
      parse("1", grammar), 
      "1");
  });

  test('eof fail', () {
    var grammar = digit & eof;
    expectFailure(
      parse("12", grammar), 
      "End of File expected");
  });
}
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:test/test.dart';
import 'helper.dart';

void main() {
  test('any', () {
    var grammar = any;
    expectSuccess(
      parse("1", grammar), 
      "1");
  });

  test('any char 5 times', () {
    var grammar = any * 5;
    expectSuccess(
      parse("12345", grammar), 
      "12345");
  });

  test('any failure', () {
    var grammar = any * 5;
    expectFailure(
      parse("1234", grammar), 
      "Any character");
  });

}
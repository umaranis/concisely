import 'dart:math';

import 'package:dallang/char.dart';
import 'package:dallang/dallang.dart';
import 'package:dallang/exception.dart';
import 'package:dallang/failure.dart';
import 'package:dallang/result.dart';
import 'package:dallang/runner.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });

  test('parseChar', () {
    expect(
      parseOrThrow("@ASSA#", char("@")), 
      "@");
  });

  test('parse2Chars', () {
    expect(
      parseOrThrow("9988", char("9") & char("9"))
        .reduce((a, b) => a + b), 
      "99");
  });

  test('times', () {
    expect(
      parseOrThrow("AAAAA", char("A") * 5)
        .reduce((a, b) => a + b), 
      "AAAAA");
  });

  test('times_error_message', () {
    expect(
      () => parseOrThrow("AAAA", char("A") * 5), 
      throwsA((e) => e is ParseException && e.result.message == '"A" expected'));
  });

  test('times_error_toString', () {
    expect(
      () => parseOrThrow("AAA", char("A") * 5), 
      throwsA((e) => e is ParseException && e.result.toString() == 'Failure[line:1, col:4] "A" expected'));
  });
}

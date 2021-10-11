import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {

  test('many', () {
    var grammar = any * many;
    expectSuccess(
      parse('123ABC@', grammar),
      ['1', '2', '3', 'A', 'B', 'C', '@']);
  });  

  test('many 1', () {
    var grammar = any * many;
    expectSuccess(
      parse('1', grammar),
      ['1']);
  });  

  test('many failure', () {
    var grammar = digit & any * many;
    expectFailure(
      parse('1', grammar),
      'Any');
  });

  test('many failure, fast parse', () {
    var grammar = digit & any * many
      > type.string;
    expectFailure(
        parse('1', grammar),
        'Any');
  });



}
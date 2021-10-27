import 'package:concisely/concisely.dart';
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
      > toStr;
    expectFailure(
        parse('1', grammar),
        'Any');
  });



}
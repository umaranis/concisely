
import 'package:concisely/debug/progress.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';
import '../helper.dart';

void main() {
  test('email somewhat', () {

    var grammar = letter 
                  & 
                  (letter | digit | char('.') ) * many
                  &
                  char('@')
                  &
                  (letter | digit) * many
                  & 
                  char('.')
                  &
                  letter * 3
                  ;

    expectSuccess(
      parse("hello.world@gmail.com", progress(grammar)), 
      [
        'h',
        ['e', 'l', 'l', 'o', '.', 'w', 'o', 'r', 'l', 'd'],
        '@',
        ['g', 'm', 'a', 'i', 'l'],
        '.',
        ['c', 'o', 'm']
      ]
    );

    expectSuccess(
      parse("hello.world@gmail.com", grammar), 
      [
        'h',
        ['e', 'l', 'l', 'o', '.', 'w', 'o', 'r', 'l', 'd'],
        '@',
        ['g', 'm', 'a', 'i', 'l'],
        '.',
        ['c', 'o', 'm']
      ]
    );

    expectSuccess(
      parse("hh@gmail.com", grammar > type.string),
      "hh@gmail.com"
    );

    expectSuccess(
      parse("hh@gmail.com", grammar), 
      ['h', ['h'], '@', ['g', 'm', 'a', 'i', 'l'], '.', ['c', 'o', 'm']]
    );
    
  });
}
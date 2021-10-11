import 'package:concisely/debug/trace.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:test/test.dart';

import '../../helper.dart';

void main() {
  
  test('list', () {
    var grammar = char('A') * 5 & char('G') * 2   > type.string;
    expectSuccess(
      parse('AAAAAGG', trace(grammar)),
      'AAAAAGG');
  });

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
                  
                  > type.string
                  ;

    expectSuccess(
      parse('hello.world@gmail.com', grammar),
      'hello.world@gmail.com'
    );
  });

  test('list choice', () {
    var grammar = (char('A') * 5 & char('C')) | (char('A') * 5 & char('G') * 2)   > type.string;
    expectSuccess(
      parse('AAAAAGG', trace(grammar)),
      'AAAAAGG');
  });
}
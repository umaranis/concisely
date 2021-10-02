import 'package:concisely/debug/trace.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {
  
  test('list', () {
    var grammar = char("A") * 5 & char("G") * 2   > list;
    expectSuccess(
      parse("AAAAAGG", grammar), 
      ['A', 'A', 'A', 'A', 'A', 'G', 'G']);
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
                  
                  > list
                  ;

    expectSuccess(
      parse("hello.world@gmail.com", grammar), 
      ['h','e','l','l','o','.','w','o','r','l','d','@','g','m','a','i','l','.','c','o','m']
    );
  });

  test('list choice', () {
    var grammar = (char("A") * 5 & char('C')) | (char("A") * 5 & char('G') * 2)   > list;
    expectSuccess(
      parse("AAAAAGG", grammar), 
      ['A', 'A', 'A', 'A', 'A', 'G', 'G']);
  });

  test('list 2 times', () {
    var grammar = (char("A") * 2 & char('G') * 2) * 2   > list;
    expectSuccess(
      parse("AAGGAAGG", trace(grammar)), 
      ['A', 'A', 'G', 'G', 'A', 'A', 'G', 'G']);
  });

  test('list many', () {
    var grammar = (char("A") * 2 & char('G') * 2) * many   > list;
    expectSuccess(
      parse("AAGGAAGG", grammar), 
      ['A', 'A', 'G', 'G', 'A', 'A', 'G', 'G']);
  });
}
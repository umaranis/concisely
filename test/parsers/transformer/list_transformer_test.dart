import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
import 'package:test/test.dart';

import '../../helper.dart';

void main() {
  
  test('list', () {
    var grammar = char('A') * 5 & char('G') * 2   > toList;
    expectSuccess(
      parse('AAAAAGG', grammar),
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
                  
                  > toList
                  ;

    expectSuccess(
      parse('hello.world@gmail.com', grammar),
      ['h','e','l','l','o','.','w','o','r','l','d','@','g','m','a','i','l','.','c','o','m']
    );
  });

  test('list choice', () {
    var grammar = (char('A') * 5 & char('C')) | (char('A') * 5 & char('G') * 2)   > toList;
    expectSuccess(
      parse('AAAAAGG', grammar),
      ['A', 'A', 'A', 'A', 'A', 'G', 'G']);
  });

  test('list 2 times', () {
    var grammar = (char('A') * 2 & char('G') * 2) * 2   > toList;
    expectSuccess(
      parse('AAGGAAGG', trace(grammar)),
      ['A', 'A', 'G', 'G', 'A', 'A', 'G', 'G']);
  });

  test('list many', () {
    var grammar = (char('A') * 2 & char('G') * 2) * many   > toList;
    expectSuccess(
      parse('AAGGAAGG', grammar),
      ['A', 'A', 'G', 'G', 'A', 'A', 'G', 'G']);
  });
}
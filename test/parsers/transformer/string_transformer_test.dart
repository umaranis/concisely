import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
import 'package:test/test.dart';

import '../../helper.dart';

void main() {
  
  test('list', () {
    var grammar = char('A') * 5 & char('G') * 2   > toStr;
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
                  
                  > toStr
                  ;

    expectSuccess(
      parse('hello.world@gmail.com', grammar),
      'hello.world@gmail.com'
    );
  });

  test('list choice', () {
    var grammar = (char('A') * 5 & char('C')) | (char('A') * 5 & char('G') * 2)   > toStr;
    expectSuccess(
      parse('AAAAAGG', trace(grammar)),
      'AAAAAGG');
  });
}
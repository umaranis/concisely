import 'package:concisely/continuation/string.dart';
import 'package:concisely/debug/progress.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/times/times.dart';
import 'package:test/test.dart';
import 'helper.dart';

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
      "hello.world@gmail.com"
    );

    expectSuccess(
      parse("hello.world@gmail.com", grammar), 
      "hello.world@gmail.com"
    );

    expectSuccess(
      parse("hh@gmail.com", StringParser(grammar)), 
      "hh@gmail.com"
    );

    expectSuccess(
      parse("hh@gmail.com", grammar), 
      "hh@gmail.com"
    );
    
  });
}
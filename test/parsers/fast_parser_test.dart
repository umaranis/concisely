import 'package:concisely/debug/trace.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/any.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';

void main() {
  test('fast parse', () {
    var grammar = any * 5 > type.string;
    
    final sb = StringBuffer();
    WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse('12345', p);
    expect(r.isSuccess, true);
    expect(sb.toString().contains('fast'), true);
  });

  test('slow parse', () {
    var grammar = (any > type.list) * 5 > type.string;

    final sb = StringBuffer();
    WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse('12345', p);
    expect(r.isSuccess, true);
    expect(sb.toString().contains('fast'), false);
  });

  test('email slow parse fast object setup', () {
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

    final sb = StringBuffer();
    WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse('hello.world@gmail.com', p);
    expect(r.isSuccess, true);
    //print(sb.toString());
    expect(sb.toString().contains('ChoiceFastParser'), true);
    expect(sb.toString().contains('SequenceFastParser'), true);   
    expect(sb.toString().contains('<fast parse>'), false); 
  });

  test('email fast parse', () {
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

    final sb = StringBuffer();
    WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse('hello.world@gmail.com', p);
    expect(r.isSuccess, true);
    //print(sb.toString());
    expect(sb.toString().contains('ChoiceFastParser'), true);
    expect(sb.toString().contains('SequenceFastParser'), true);  
    expect(sb.toString().contains('<fast parse>'), true);
  });
}

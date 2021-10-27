import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
import 'package:test/test.dart';

void main() {
  test('fast parse', () {
    var grammar = any * 5 > toStr;
    
    final sb = StringBuffer();
    Parser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
    final r = parse('12345', p);
    expect(r.isSuccess, true);
    expect(sb.toString().contains('fast'), true);
  });

  test('slow parse', () {
    var grammar = (any > toList) * 5 > toStr;

    final sb = StringBuffer();
    Parser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
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
    Parser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
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
                  
                  > toStr
                  ;   

    final sb = StringBuffer();
    Parser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
    final r = parse('hello.world@gmail.com', p);
    expect(r.isSuccess, true);
    //print(sb.toString());
    expect(sb.toString().contains('ChoiceFastParser'), true);
    expect(sb.toString().contains('SequenceFastParser'), true);  
    expect(sb.toString().contains('<fast parse>'), true);
  });
}

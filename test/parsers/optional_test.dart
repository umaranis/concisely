import 'package:concisely/concisely.dart';
import 'package:concisely/debug.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {

  test('optional', () {

    var grammar =
    char('A') * 5
    &
    char('G') * 2 * optional
    ;

    expectSuccess(
        parse('AAAAA', grammar),
        [['A', 'A', 'A', 'A', 'A'], null]);
  });

  test('optional fast parser', () {

    var grammar = 
      char('A') * 5
      & 
      char('G') * 2 * optional

      > toStr
    ;    
    
    expectSuccess(
      parse('AAAAA', grammar),
      'AAAAA');
  });

  test('optional trace', () {

    var grammar =
        char('A') * 5
        &
        char('G') * 2 * optional
    ;

    final sb = StringBuffer();
    Parser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
    final r = parse('AAAAA', p);
    expect(r.isSuccess, true);
    expect(sb.toString().contains('optional'), true);
  });


}
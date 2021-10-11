import 'package:concisely/debug/trace.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/base/transformer.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
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
        [['A', 'A', 'A', 'A', 'A']]);
  });

  test('optional fast parser', () {

    var grammar = 
      char('A') * 5
      & 
      char('G') * 2 * optional

      > type.string
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
    WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
    final r = parse('AAAAA', p);
    expect(r.isSuccess, true);
    expect(sb.toString().contains('optional'), true);
  });


}
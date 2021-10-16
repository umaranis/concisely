import 'package:concisely/debug/trace.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';

import '../helper.dart';

void main() {
  test('email somewhat trace', () {

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
                  &
                  eof
                  ;

    final log = 
"""
SequenceFastParser  [Sequence]
  LetterParser  [letter]
  Success[1]: h
  ManyFastParser  [letter or digit or "." * many times]
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[2]: e
    Success[2]: e
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[3]: l
    Success[3]: l
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[4]: l
    Success[4]: l
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[5]: o
    Success[5]: o
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Failure[5]: letter expected
      DigitParser  [digit]
      Failure[5]: digit expected
      CharParser  ["."]
      Success[6]: .
    Success[6]: .
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[7]: w
    Success[7]: w
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[8]: o
    Success[8]: o
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[9]: r
    Success[9]: r
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[10]: l
    Success[10]: l
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Success[11]: d
    Success[11]: d
    ChoiceFastParser  [letter or digit or "."]
      LetterParser  [letter]
      Failure[11]: letter expected
      DigitParser  [digit]
      Failure[11]: digit expected
      CharParser  ["."]
      Failure[11]: "." expected
    Failure[11]: letter or digit or "." expected
  Success[11]: [e, l, l, o, ., w, o, r, l, d]
  CharParser  ["@"]
  Success[12]: @
  ManyFastParser  [letter or digit * many times]
    ChoiceFastParser  [letter or digit]
      LetterParser  [letter]
      Success[13]: g
    Success[13]: g
    ChoiceFastParser  [letter or digit]
      LetterParser  [letter]
      Success[14]: m
    Success[14]: m
    ChoiceFastParser  [letter or digit]
      LetterParser  [letter]
      Success[15]: a
    Success[15]: a
    ChoiceFastParser  [letter or digit]
      LetterParser  [letter]
      Success[16]: i
    Success[16]: i
    ChoiceFastParser  [letter or digit]
      LetterParser  [letter]
      Success[17]: l
    Success[17]: l
    ChoiceFastParser  [letter or digit]
      LetterParser  [letter]
      Failure[17]: letter expected
      DigitParser  [digit]
      Failure[17]: digit expected
    Failure[17]: letter or digit expected
  Success[17]: [g, m, a, i, l]
  CharParser  ["."]
  Success[18]: .
  MultipleTimesFastParser  [letter * 3 times]
    LetterParser  [letter]
    Success[19]: c
    LetterParser  [letter]
    Success[20]: o
    LetterParser  [letter]
    Success[21]: m
  Success[21]: [c, o, m]
  EOFParser  [End of File]
  Success[21]: <blank>
Success[21]: [h, [e, l, l, o, ., w, o, r, l, d], @, [g, m, a, i, l], ., [c, o, m]]
""";
    
    final sb = StringBuffer();
    WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse("hello.world@gmail.com", p);
    expect(r.isSuccess, true);
    expect(sb.toString(), log);
  });

  test('email somewhat trace print', () {

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
                  &
                  eof
                  ;

    expectSuccess(
      parse("hello.world@gmail.com", trace(grammar)), 
      [
        'h',
        ['e', 'l', 'l', 'o', '.', 'w', 'o', 'r', 'l', 'd'],
        '@',
        ['g', 'm', 'a', 'i', 'l'],
        '.',
        ['c', 'o', 'm']
      ]
    );      
  });
}

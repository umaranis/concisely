import 'package:concisely/debug/progress.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:test/test.dart';

import '../expect_parse_helper.dart';

void main() {
  test('email somewhat progress', () {

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
* SequenceFastParser called    [Sequence]
* LetterParser called    [letter]
** ManyFastParser called    [letter or digit or "." * many times]
** ChoiceFastParser called    [letter or digit or "."]
** LetterParser called    [letter]
*** ChoiceFastParser called    [letter or digit or "."]
*** LetterParser called    [letter]
**** ChoiceFastParser called    [letter or digit or "."]
**** LetterParser called    [letter]
***** ChoiceFastParser called    [letter or digit or "."]
***** LetterParser called    [letter]
****** ChoiceFastParser called    [letter or digit or "."]
****** LetterParser called    [letter]
****** DigitParser called    [digit]
****** CharParser called    ["."]
******* ChoiceFastParser called    [letter or digit or "."]
******* LetterParser called    [letter]
******** ChoiceFastParser called    [letter or digit or "."]
******** LetterParser called    [letter]
********* ChoiceFastParser called    [letter or digit or "."]
********* LetterParser called    [letter]
********** ChoiceFastParser called    [letter or digit or "."]
********** LetterParser called    [letter]
*********** ChoiceFastParser called    [letter or digit or "."]
*********** LetterParser called    [letter]
************ ChoiceFastParser called    [letter or digit or "."]
************ LetterParser called    [letter]
************ DigitParser called    [digit]
************ CharParser called    ["."]
************ CharParser called    ["@"]
************* ManyFastParser called    [letter or digit * many times]
************* ChoiceFastParser called    [letter or digit]
************* LetterParser called    [letter]
************** ChoiceFastParser called    [letter or digit]
************** LetterParser called    [letter]
*************** ChoiceFastParser called    [letter or digit]
*************** LetterParser called    [letter]
**************** ChoiceFastParser called    [letter or digit]
**************** LetterParser called    [letter]
***************** ChoiceFastParser called    [letter or digit]
***************** LetterParser called    [letter]
****************** ChoiceFastParser called    [letter or digit]
****************** LetterParser called    [letter]
****************** DigitParser called    [digit]
****************** CharParser called    ["."]
******************* MultipleTimesFastParser called    [letter * 3 times]
******************* LetterParser called    [letter]
******************** LetterParser called    [letter]
********************* LetterParser called    [letter]
********************** EOFParser called    [End of File]
""";
    
    final sb = StringBuffer();
    WrapperParser p = progress(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse("hello.world@gmail.com", p);
    //print(sb.toString());
    expect(r.isSuccess, true);
    expect(sb.toString(), log);
  });

  test('email somewhat progress print', () {

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
   
    expectParse.pass(progress(grammar),
      "hello.world@gmail.com",
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

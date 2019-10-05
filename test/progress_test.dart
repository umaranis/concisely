import 'package:concisely/debug/progress.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/char/digit.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/times/times.dart';
import 'package:test/test.dart';

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
                  &
                  eof
                  ;

    final log = 
"""
* SequenceParser called    [Sequence]
* LetterParser called    [letter]
** ManyParser called    [letter or digit or "."* many]
** ChoiceParser called    [letter or digit or "."]
** LetterParser called    [letter]
*** ChoiceParser called    [letter or digit or "."]
*** LetterParser called    [letter]
**** ChoiceParser called    [letter or digit or "."]
**** LetterParser called    [letter]
***** ChoiceParser called    [letter or digit or "."]
***** LetterParser called    [letter]
****** ChoiceParser called    [letter or digit or "."]
****** LetterParser called    [letter]
****** DigitParser called    [digit]
****** CharParser called    ["."]
******* ChoiceParser called    [letter or digit or "."]
******* LetterParser called    [letter]
******** ChoiceParser called    [letter or digit or "."]
******** LetterParser called    [letter]
********* ChoiceParser called    [letter or digit or "."]
********* LetterParser called    [letter]
********** ChoiceParser called    [letter or digit or "."]
********** LetterParser called    [letter]
*********** ChoiceParser called    [letter or digit or "."]
*********** LetterParser called    [letter]
************ ChoiceParser called    [letter or digit or "."]
************ LetterParser called    [letter]
************ DigitParser called    [digit]
************ CharParser called    ["."]
************ CharParser called    ["@"]
************* ManyParser called    [letter or digit* many]
************* ChoiceParser called    [letter or digit]
************* LetterParser called    [letter]
************** ChoiceParser called    [letter or digit]
************** LetterParser called    [letter]
*************** ChoiceParser called    [letter or digit]
*************** LetterParser called    [letter]
**************** ChoiceParser called    [letter or digit]
**************** LetterParser called    [letter]
***************** ChoiceParser called    [letter or digit]
***************** LetterParser called    [letter]
****************** ChoiceParser called    [letter or digit]
****************** LetterParser called    [letter]
****************** DigitParser called    [digit]
****************** CharParser called    ["."]
******************* MultipleTimesFastParser called    [letter * 3 times]
******************* LetterParser called    [letter]   <fast parse>
******************** LetterParser called    [letter]   <fast parse>
********************* LetterParser called    [letter]   <fast parse>
********************** EOFParser called    [End of File]
""";
    
    final sb = StringBuffer();
    WrapperParser p = progress(grammar, (obj) => sb.writeln(obj.toString()));              
    final r = parse("hello.world@gmail.com", p);
    expect(r.isSuccess, true);
    expect(sb.toString(), log);
  });
}

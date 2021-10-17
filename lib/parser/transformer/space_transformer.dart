import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/parser/combiner/sequence.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/skip_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

mixin SpaceTransformer {
  SequenceParser transform(SequenceParser parser);
}

final spaceTrim = whitespace.zeroOrMore.skip;

/// Transforms the grammar to skip whitespaces between parsers in a sequence (&)
/// `char('1') & char('+') & char('2') > space.trim`     is transformed to      `whitespace.zeroOrMore & char('1') & whitespace.zeroOrMore & char('+') & whitespace.zeroOrMore & char('2') & whitespace.zeroOrMore`
class SpaceTrimTransformer extends Transformer with SpaceTransformer {
  SpaceTrimTransformer(Parser parser) : super(parser);

  @override
  String get label => 'Trim space transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    throw UnimplementedError();
  }

  @override
  SequenceParser transform(SequenceParser parser) {
    var list = parser.parsers;
    if(list.length > 0 && !isSpaceTrimParser(list.first)) {
      list.insert(0, spaceTrim);
    }

    int i = 1;
    while(i < list.length - 1) {
      if(!isSpaceTrimParser(list[i])) {
        if(!isSpaceTrimParser(list[i + 1])) {
          list.insert(i + 1, spaceTrim);
        }
        i += 2;
      }
      else {
        i += 1;
      }
    }

    if(!isSpaceTrimParser(list.last)) {
      list.add(spaceTrim);
    }

    return parser;
  }

  bool isSpaceTrimParser(Parser parser) {
    return parser == spaceTrim;
  }
  
}
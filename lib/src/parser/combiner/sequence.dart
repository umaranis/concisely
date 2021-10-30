import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/list_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/combiner/sequence_fast.dart';
import 'package:concisely/src/parser/other/space_trim_parser.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';
import 'package:concisely/src/result/success.dart';

/// Combines of list of parsers to be applied in a sequence
class SequenceParser extends ListParser {

  SequenceParser(List<Parser> parsers) : super(parsers);

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    final combiner = getCombiner(outputType);    
    var currentResult;
    for (var parser in parsers) {
      currentResult = parser.parse(context, outputType);
      if(currentResult.isFailure) {
        return currentResult;
      }
      else {
        context = currentResult.context;
        combiner.append(currentResult.value);
      }
    }

    return Success(currentResult.context, combiner.result);
  }      

  @override
  String get name => 'Sequence';

  @override
  SequenceParser operator & (Parser other) {
    parsers.add(other);
    return this;
  }

  @override
  SequenceParser operator + (Parser other) {
    parsers.add(spaceTrim);
    parsers.add(other);
    return this;
  }

  @override
  bool hasEqualProperties(SequenceParser other) => true;
  
}

extension ToSeqExtension on List<Parser> {
  /// Converts a list of parsers into a SequenceParser
  ///
  /// Similar to '&' with a subtle difference:
  ///     Parser px = p1 & p2;
  ///     Parser py = px & p3;
  ///     py is equivalent to p1 & p2 & p3
  ///     sample parse result: [ p1Result, p2Result, p3Result ]
  ///
  ///     Parser px = [p1, p2].toSequenceParser();
  ///     Parser py = [px, p3].toSequenceParser();
  ///     py is NOT equivalent to p1 & p2 & p3
  ///     sample parse result: [ [p1Result, p2Result], p3Result ]
  SequenceParser get toSeq {
    return this.every((element) => element is FastParser)? SequenceFastParser(this) : SequenceParser(this);
  }
}

extension ToTrimSeq on List<Parser> {
  /// Converts a list of parsers into a SequenceParser which also trims any whitespace between parsers
  ///
  /// Similar to '+' with a subtle difference:
  ///     Parser px = p1 + p2;
  ///     Parser py = px + p3;
  ///     py is equivalent to p1 + p2 + p3
  ///     sample parse result: [ p1Result, p2Result, p3Result ]
  ///
  ///     Parser px = [p1, p2].toTrimSeq;
  ///     Parser py = [px, p3].toTrimSeq;
  ///     py is NOT equivalent to p1 + p2 + p3
  ///     sample parse result: [ [p1Result, p2Result], p3Result ]
  SequenceParser get toTrimSeq {

    var list = this;
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

    return SequenceParser(list);
  }
}

bool isSpaceTrimParser(Parser parser) {
  return parser == spaceTrim;
}


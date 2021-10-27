import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/char/whitespace.dart';
import 'package:concisely/src/parser/combiner/sequence.dart';
import 'package:concisely/src/parser/combiner/sequence_fast.dart';
import 'package:concisely/src/parser/repeater/times.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';

final spaceTrim = whitespace.zeroOrMore.skip;

extension SpaceTrimmingSequenceExtensions on Parser {
  SequenceParser operator +(Parser other) {
    if(this is FastParser && other is FastParser) {
      return SequenceFastParser([this, spaceTrim, other]);
    }
    else {
      return SequenceParser([this, spaceTrim, other]);
    }
  }
}

extension SpaceTrimmingSequenceExtensions2 on SequenceParser {
  SequenceParser operator +(Parser other) {
    parsers.add(spaceTrim);
    parsers.add(other);
    return this;
  }
}

extension SpaceTrimmingSequenceExtensions3 on SequenceFastParser {
  SequenceParser operator +(Parser other) {
    parsers.add(spaceTrim);
    parsers.add(other);
    return other is FastParser ? this : SequenceParser(parsers);
  }
}
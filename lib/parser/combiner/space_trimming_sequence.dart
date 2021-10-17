import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/combiner/sequence.dart';
import 'package:concisely/parser/combiner/sequence_fast.dart';
import 'package:concisely/parser/transformer/space_transformer.dart';

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
  @override
  SequenceParser operator +(Parser other) {
    parsers.add(spaceTrim);
    parsers.add(other);
    return this;
  }
}

extension SpaceTrimmingSequenceExtensions3 on SequenceFastParser {
  @override
  SequenceParser operator +(Parser other) {
    parsers.add(spaceTrim);
    parsers.add(other);
    return other is FastParser ? this : SequenceParser(parsers);
  }
}
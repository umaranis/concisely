import 'package:concisely/context.dart';
import 'package:concisely/parser/combiner/choice.dart';
import 'package:concisely/parser/combiner/choice_fast.dart';
import 'package:concisely/parser/combiner/sequence.dart';
import 'package:concisely/parser/combiner/sequence_fast.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';

import 'fast_parser.dart';

abstract class Parser<T> {
  Result<T?> parse(Context context, [OutputType outputType = OutputType.tree]);

  /// Label for the parser like 'Any Character', 'letter', 'digit' etc. 
  String get label;

  SequenceParser operator & (Parser other) => (this is FastParser && other is FastParser)? SequenceFastParser([this, other]) : SequenceParser([this, other]);
  Parser operator * (Object times) => timesFactory(this, times);
  Parser operator | (Parser other) => (this is FastParser && other is FastParser)? ChoiceFastParser([this, other]) : ChoiceParser([this, other]);

  Iterable<Parser> get children => const [];
  void replace(Parser source, Parser target) {}
}
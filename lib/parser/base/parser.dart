import 'package:concisely/context.dart';
import 'package:concisely/parser/combiner/choice.dart';
import 'package:concisely/parser/combiner/sequence.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/times/times.dart';

abstract class Parser<T> {
  Result<T> parse(Context context); 

  /// Label for the parser like 'Any Character', 'letter', 'digit' etc. 
  String get label;

  Parser operator & (Parser other) => SequenceParser([this, other]);
  Parser operator * (Object times) => timesFactory(this, times);
  Parser operator | (Parser other) => ChoiceParser([this, other]);
}



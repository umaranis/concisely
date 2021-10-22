import 'package:concisely/context.dart';
import 'package:concisely/parser/combiner/choice.dart';
import 'package:concisely/parser/combiner/choice_fast.dart';
import 'package:concisely/parser/combiner/sequence.dart';
import 'package:concisely/parser/combiner/sequence_fast.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result.dart';
import 'package:meta/meta.dart';

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

  /// Recursively tests for deep equality of two parsers.
  ///
  /// The code automatically deals with recursive parsers and parsers that
  /// refer to other parsers. Do not override this method, instead customize
  /// [Parser.hasEqualProperties] and [Parser.children].
  @nonVirtual
  bool equals(Parser other, [Set<Parser>? seen]) {
    if(identical(this,other)) {
      return true;
    }
    if (runtimeType != other.runtimeType || !hasEqualProperties(other)) {
      return false;
    }
    seen ??= {};
    return !seen.add(this) || hasEqualChildren(other, seen);
  }

  /// Compare the properties of two parsers (not the child parsers, they are compared by [hasEqualChildren].
  @protected
  bool hasEqualProperties(covariant Parser other);

  /// Compare the children of two parsers.
  ///
  /// Normally this method does not need to be overridden, as this method works
  /// generically on the returned [Parser.children].
  @protected
  @nonVirtual
  bool hasEqualChildren(covariant Parser other, Set<Parser> seen) {
    final thisChildren = children.iterator, otherChildren = other.children.iterator;

    while(true) {
      bool hasMore1 = thisChildren.moveNext();
      bool hasMore2 = otherChildren.moveNext();

      if(hasMore2 != hasMore2) {
        return false;
      }

      if(hasMore1) {
        if(!thisChildren.current.equals(otherChildren.current, seen)) {
          return false;
        }
      }
      else {
        return true;
      }
    }
  }
}
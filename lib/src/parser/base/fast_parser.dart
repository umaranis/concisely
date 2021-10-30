import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';

/// Reduces the memory allocation by not allocating memory during parsing.
/// [char('A') * 3] produces 'AAA' instead of ['A','A','A']
/// Fast parsers only work when the output is actually a part of input string. That is, input is only matched with a pattern without any transformation.
mixin FastParser<T> on Parser<T> {
  
  /// Reduces memory allocation by not allocating memory for result and new context
  /// As new context is not created, [position] variable is used to track the current position.
  int fastParse(Context context, int position);
  
  /// Produces the result of [fastParse].
  /// Usually called after [fastParse] as it's return value has to be passed into [endPosition].
  /// 
  /// To reduce memory allocation, new [Context] objects are not created in fast parsing, 
  /// rather [startPosition] holds the offset where this parser started and [endPosition] is where it ended.
  String getFastParseResult(Context context, int startPosition, int endPosition);
}
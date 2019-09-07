import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';

/// Reduces the memory allocation by not allocating memory during parsing.
/// [char('A') * 3] produces 'AAA' instead of ['A','A','A']
/// Fast parsers only work when the output is actually a part of input string. That is, input is only matched with a pattern without any transformation.
abstract class FastParser<T> extends Parser{
  
  /// Reduces memory allocation by not allocating memory for result and new context
  /// As new context is not created, [offset] tells you where to start ahead of the current position.
  int fastParse(Context context, int offset);
  
  /// Produces the result of [fastParse].
  /// Should be called after [fastParse] as it's return value has to be passed into [resultPosition].
  /// 
  /// To reduce memory allocation, new [Context] objects are not created in fast parsing, 
  /// rather [initialOffset] holds the offset where this parser started and [resultPosition] is where it ended.
  T getFastParseResult(Context context, int initialOffset, int resultPosition);

  String getFastParseMessage();
}
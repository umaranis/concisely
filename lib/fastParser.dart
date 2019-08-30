import 'package:conciseparser/context.dart';
import 'package:conciseparser/parser.dart';

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
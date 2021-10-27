import 'package:concisely/src/context.dart';
import 'fast_parser.dart';

/// Default way for retrieving fast parse result
mixin DefaultFastParseResult on FastParser {
  @override
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return context.subStringFromOffset(startPosition, endPosition);
  }
}
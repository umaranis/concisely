import 'package:concisely/context.dart';
import 'package:concisely/parser/base/fast_parser.dart';

/// Default way for retrieving fast parse result
mixin DefaultFastParseResult on FastParser {
  @override
  String getFastParseResult(Context context, int startPosition, int endPosition) {
    return context.subStringFromOffset(startPosition, endPosition);
  }
}
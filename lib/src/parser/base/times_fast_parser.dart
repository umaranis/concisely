import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/parent_parser.dart';

mixin ParentFastParser<T> on ParentParser<T>, FastParser<T> {
  FastParser get fastParser => parser as FastParser;
}
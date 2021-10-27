import 'package:concisely/src/parser/base/fast_parser.dart';
import 'package:concisely/src/parser/base/parent_parser.dart';

mixin ParentFastParser on ParentParser, FastParser {
  FastParser get fastParser => parser as FastParser;
}
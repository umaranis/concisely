import 'package:concisely/parser/base/fast_parser.dart';
import 'package:concisely/parser/base/parent_parser.dart';

mixin TimesFastParser on ParentParser, FastParser {
  FastParser get fastParser => parser as FastParser;   
}
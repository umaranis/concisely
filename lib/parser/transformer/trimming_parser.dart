import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/char/whitespace.dart';
import 'package:concisely/parser/times/times.dart';
import 'package:concisely/parser/transformer/pick_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';

extension TrimmingExtension on Parser {
  Parser get trim => whitespace.zeroOrMore & this & whitespace.zeroOrMore > pick(1);
}
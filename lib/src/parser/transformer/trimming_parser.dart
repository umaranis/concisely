import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/char/whitespace.dart';
import 'package:concisely/src/parser/repeater/times.dart';
import 'package:concisely/src/parser/transformer/pick_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';

extension TrimmingExtension on Parser {
  Parser get trim => whitespace.zeroOrMore & this & whitespace.zeroOrMore > pick(1);
}
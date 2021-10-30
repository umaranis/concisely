import 'package:concisely/src/parser/char/whitespace.dart';
import 'package:concisely/src/parser/repeater/times.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';

final spaceTrim = whitespace.zeroOrMore.skip;
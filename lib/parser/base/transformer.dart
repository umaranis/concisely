import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/list_transformer.dart';
import 'package:concisely/parser/transformer/string_transformer.dart';
import 'package:concisely/parser/transformer/tree_transformer.dart';

abstract class Transformer extends ParentParser {
  Transformer(Parser parser) : super(parser);
}

Transformer get tree => TreeTransformer(null);
Transformer get list => ListTransformer(null);
Transformer get string => StringTransformer(null);

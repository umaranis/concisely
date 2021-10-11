import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/list_transformer.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:concisely/parser/transformer/string_transformer.dart';
import 'package:concisely/parser/transformer/tree_transformer.dart';

abstract class Transformer extends ParentParser {
  Transformer(Parser parser) : super(parser);
}

class TypeTransformers {
  /// Default behaviour - Presents results in a tree
  /// parsing 123.34 with   digit.many & char('.') & digit.many   gives us   [ ['1',2','3'] , '.', ['4','5'] ]
  Transformer get tree => TreeTransformer(null);
  /// Transforms the results into a list
  /// parsing 123.34 with   digit.many & char('.') & digit.many   gives us   ['1',2','3','.','4','5']
  Transformer get list => ListTransformer(null);
  /// Transforms the results into a string
  /// parsing 123.34 with   digit.many & char('.') & digit.many   gives us   '123.34'
  Transformer get string => StringTransformer(null);
}

/// Provides a number of transformation to change to type of the result.
/// For example, tree, list, string etc.
TypeTransformers type = TypeTransformers();
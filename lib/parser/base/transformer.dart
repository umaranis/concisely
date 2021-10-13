import 'package:concisely/parser/other/failure_parser.dart';
import 'package:concisely/parser/base/parent_parser.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/bool_transformer.dart';
import 'package:concisely/parser/transformer/float_transformer.dart';
import 'package:concisely/parser/transformer/int_transformer.dart';
import 'package:concisely/parser/transformer/list_transformer.dart';
import 'package:concisely/parser/transformer/map_transformer.dart';
import 'package:concisely/parser/transformer/string_fast_transformer.dart';
import 'package:concisely/parser/transformer/string_transformer.dart';
import 'package:concisely/parser/transformer/tree_transformer.dart';

import 'fast_parser.dart';

abstract class Transformer extends ParentParser {
  Transformer(Parser parser) : super(parser);
}

extension TransformerExtensions on Parser {
  Parser operator > (Transformer transformer) {
    if(this is FastParser && transformer is StringTransformer) {
      return StringFastTransformer(this);
    }
    else if (transformer is MapTransformer) {
      ParentParser parent = transformer;
      while(parent.p != ConstantFailureParser()) {
        parent = parent.p as ParentParser;
      }
      parent.p = this;
      return transformer;
    }
    else {
      transformer.p = this;
      return transformer;
    }
  }
}

class TypeTransformers {
  /// Default behaviour - Presents results in a tree
  /// parsing 123.34 with   digit.many & char('.') & digit.many > type.tree   gives us  <br/> [ ['1',2','3'] , '.', ['4','5'] ]
  Transformer get tree => TreeTransformer(ConstantFailureParser());
  /// Transforms the results into a list
  /// parsing 123.34 with   digit.many & char('.') & digit.many > type.list   gives us <br/> ['1',2','3','.','4','5']
  Transformer get list => ListTransformer(ConstantFailureParser());
  /// Transforms the results into a string
  /// parsing 123.34 with   digit.many & char('.') & digit.many > type.string   gives us <br/> '123.34'
  Transformer get string => StringTransformer(ConstantFailureParser());
  /// Transforms the results into an integer
  /// parsing 123 with   digit.many & char('.') & digit.many > type.int   gives us <br/> 123
  Transformer get int => IntTransformer(ConstantFailureParser());
  /// Transforms the results into a floating point number (double)
  /// parsing 123 with   digit.many & char('.') & digit.many > type.float   gives us <br/> 123.0
  Transformer get float => FloatTransformer(ConstantFailureParser());
  /// Transforms the results into a Boolean value (bool)
  /// parsing 'True' with   letter.many > type.bool   gives us <br/> true
  Transformer get bool => BooleanTransformer(ConstantFailureParser());
}

/// Provides a number of transformation to change to type of the result.
/// For example, tree, list, string etc.
TypeTransformers type = TypeTransformers();
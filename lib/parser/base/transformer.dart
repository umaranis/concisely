import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/transformer/list_transformer.dart';
import 'package:concisely/parser/transformer/string_transformer.dart';
import 'package:concisely/parser/transformer/tree_transformer.dart';

abstract class Transformer extends Parser {  
  Parser parser;

  Transformer(this.parser);

  @override  
  Iterable<Parser> get children => [parser];

  @override
  void replace(Parser source, Parser target) { 
    parser = target;
  }
}

Transformer get tree => TreeTransformer(null);
Transformer get list => ListTransformer(null);
Transformer get string => StringTransformer(null);

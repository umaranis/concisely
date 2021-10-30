import 'package:concisely/src/debug/label.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/consume_transformer.dart';
import 'package:concisely/src/parser/transformer/map_transformer.dart';
import 'package:concisely/src/parser/transformer/string_transformer.dart';
import 'package:concisely/src/parser/base/fast_parser.dart';

abstract class Transformer<T> extends ParentParser<T> {
  Transformer(Parser parser) : super(parser);
}

extension TransformerExtensions on Parser {
  Parser operator > (Transformer transformer) {
    if(this is FastParser && transformer is StringTransformer) {
      return StringFastTransformer(this);
    }
    else if (transformer is MapTransformer || transformer is ConsumeTransformer || transformer is LabelledParser) {
      ParentParser parent = transformer;
      while(parent.parser != ConstantFailureParser()) {
        parent = parent.parser as ParentParser;
      }
      parent.replace(parent.parser, this);
      return transformer;
    }
    else {
      transformer.replace(transformer.parser, this);
      return transformer;
    }
  }
}




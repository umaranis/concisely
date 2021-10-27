import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

class TreeTransformer extends Transformer {

  TreeTransformer(Parser parser) : super(parser);

  @override
  String get name => 'Tree Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return parser.parse(context, OutputType.tree);
  }

  @override
  bool hasEqualProperties(TreeTransformer other) => true;
  
}

/// Default behaviour - Presents results in a tree
/// parsing 123.34 with   digit.many & char('.') & digit.many > toTree   gives us  <br/> [ ['1',2','3'] , '.', ['4','5'] ]
Transformer get toTree => TreeTransformer(ConstantFailureParser());

extension ToListExtension on Parser {
  /// Default behaviour - Presents results in a tree
  /// parsing 123.34 with   digit.many & char('.') & digit.many > toTree   gives us  <br/> [ ['1',2','3'] , '.', ['4','5'] ]
  Transformer get toTree => TreeTransformer(this);

}


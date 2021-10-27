import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

class ListTransformer extends Transformer {

  ListTransformer(Parser parser) : super(parser);

  @override
  String get name => 'List Transformer';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return parser.parse(context, OutputType.list);
  }

  @override
  bool hasEqualProperties(ListTransformer other) => true;
  
}

/// Transforms the result into a list
///
/// Example:
///     parsing '123.34' with   digit.many & char('.') & digit.many > toList   gives us   ['1',2','3','.','4','5']
///     without list transformer, the result would be a tree   [ ['1',2','3'] , '.', ['4','5'] ]
Transformer get toList => ListTransformer(ConstantFailureParser());

extension ToListExtension on Parser {
  /// Transforms the result into a list
  ///
  /// Example:
  ///     parsing '123.34' with   digit.many & char('.') & digit.many > toList   gives us   ['1',2','3','.','4','5']
  ///     without list transformer, the result would be a tree   [ ['1',2','3'] , '.', ['4','5'] ]
  Transformer get toList => ListTransformer(this);
}
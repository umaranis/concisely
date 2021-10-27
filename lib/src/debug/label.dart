import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';

class LabelledParser extends Transformer {
  LabelledParser(Parser parser, this.label) : super(parser);

  late String label;

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    return parser.parse(context);
  }

  @override
  String get name => 'label: $label';

  @override
  bool hasEqualProperties(LabelledParser other) => this.label == other.label;
}

extension LabelExtension on Parser {
  LabelledParser label(String label) {
    return LabelledParser(this, label);
  }
}
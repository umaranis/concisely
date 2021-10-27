import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:concisely/src/result/result_combiner/result_combiner.dart';

class TreeResultCombiner extends ResultCombiner {
  final resultTree = [];

  @override
  void append(Object? value) {
    if (value != blank) {
      resultTree.add(value);
    }
  }

  @override  
  get result => resultTree;  
}
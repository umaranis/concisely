import 'package:concisely/result/result_combiner/result_combiner.dart';

class TreeResultCombiner extends ResultCombiner {
  final resultTree = [];

  @override
  void append(Object value) {
    resultTree.add(value);
  }

  @override  
  get result => resultTree;  
}
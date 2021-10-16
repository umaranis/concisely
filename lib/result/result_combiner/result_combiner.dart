import 'package:concisely/result/output_type.dart';
import 'package:concisely/result/result_combiner/list_combiner.dart';
import 'package:concisely/result/result_combiner/string_combiner.dart';
import 'package:concisely/result/result_combiner/tree_combiner.dart';

abstract class ResultCombiner {
  void append(Object? value);
  Object get result;
}

ResultCombiner getCombiner(OutputType outputType) {
    switch (outputType) {
      case OutputType.list:
        return ListResultCombiner();
      case OutputType.string:
        return StringResultCombiner();  
      default:
        return TreeResultCombiner();
    }
  }
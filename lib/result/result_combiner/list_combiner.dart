import 'package:concisely/parser/transformer/skip_transformer.dart';
import 'package:concisely/result/result_combiner/result_combiner.dart';

class ListResultCombiner extends ResultCombiner {
  final resultList = [];

  @override
  void append(Object? value) {
    if(value is List) {
      resultList.addAll(value);
    } 
    else if (value != blank) {
      resultList.add(value);
    }
  }

  @override  
  get result => resultList;  
}
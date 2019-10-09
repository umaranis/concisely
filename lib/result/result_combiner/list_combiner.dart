import 'package:concisely/result/result_combiner/result_combiner.dart';

class ListResultCombiner extends ResultCombiner {
  final resultList = [];

  @override
  void append(Object value) {
    if(value is List) {
      resultList.addAll(value);
    } 
    else {
      resultList.add(value);
    }
  }

  @override  
  get result => resultList;  
}
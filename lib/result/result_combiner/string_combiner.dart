import 'package:concisely/result/result_combiner/result_combiner.dart';

class StringResultCombiner extends ResultCombiner {
  final StringBuffer stringResult = StringBuffer();

  @override
  void append(Object value) {
    stringResult.write(value);
  }

  @override  
  get result => stringResult.toString();
  
}

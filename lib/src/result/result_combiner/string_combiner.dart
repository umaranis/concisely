import 'package:concisely/src/result/result_combiner/result_combiner.dart';

class StringResultCombiner extends ResultCombiner {
  final StringBuffer stringResult = StringBuffer();

  @override
  void append(Object? value) {
    if(value is List) {
      value.forEach((element) => stringResult.write(element));
    }
    else {
      stringResult.write(value);
    }
  }

  @override  
  get result => stringResult.toString();
  
}

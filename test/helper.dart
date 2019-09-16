import 'package:concisely/result/result.dart';
import 'package:test/test.dart';

void expectSuccess(Result r, Object expected) {
  expect(r.isSuccess, true, reason: r.toString());
  expect(r.value, expected);  
}

void expectFailure(Result r, [Object message]) {
  String resultString = r.toString();
  expect(r.isFailure, true, reason: "Failure expected instead of Success");
  if(message != null) {
    expect(resultString.contains(message), true, reason: "Error message is not matching: \n >> " + resultString + "\n >> " + message );  
  }
}
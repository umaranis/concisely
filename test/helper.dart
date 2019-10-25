import 'package:concisely/debug/progress.dart';
import 'package:concisely/debug/trace.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/executor.dart';
import 'package:concisely/parser/base/parser.dart';
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

void expectTrace(Parser grammar, String input, Object result, String log) {
  final sb = StringBuffer();
  WrapperParser p = trace(grammar, (obj) => sb.writeln(obj.toString()));
  final r = parse(input, p);
  expect(r.isSuccess, true);
  expect(sb.toString().contains(log), true, reason: 'Actual trace log does not contain expected log');
}

void expectProgress(Parser grammar, String input, Object result, String log) {
  final sb = StringBuffer();
  WrapperParser p = progress(grammar, (obj) => sb.writeln(obj.toString()));
  final r = parse(input, p);
  expect(r.isSuccess, true);
  expect(sb.toString().contains(log), true, reason: 'Actual progress log does not contain expected log');
}
import 'package:concisely/concisely.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/debug/progress.dart';
import 'package:concisely/src/debug/trace.dart';
import 'package:concisely/src/debug/wrapper.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/result/result.dart';
import 'package:test/test.dart';

@deprecated
void expectSuccess(Result r, Object? expected) {
  expect(r.isSuccess, true, reason: r.toString());
  expect(r.value, expected);  
}

@deprecated
void expectParse(Parser p, String input, Object expectedResult) {
  var actual = p.parse(Context(input, 0));
  expect(actual.isSuccess, true, reason: actual.toString());
  expect(actual.value, expectedResult);
}

@deprecated
void expectFailure(Result r, [String message = '']) {
  var resultString = r.toString();
  expect(r.isFailure, true, reason: 'Failure expected instead of Success');
  if(message != '') {
    expect(resultString.contains(message), true, reason: 'Error message is not matching: \n >> ' + resultString + '\n >> ' + message );
  }
}

/// Applies the grammar to given input and ensures that:
/// 1  - parsing is successful
/// 2  - matches the expected output
/// 3a - actual trace log contains the given log message if [logMatches] is true
/// 3b - actual trace log does not contain the given log message if [logMatches] is false
void expectTrace(Parser grammar, String input, Object result, String log, [bool logMatches = true]) {
  _expectLog(trace , 'trace', grammar, input, result, log, logMatches);
}

/// Applies the grammar to given input and ensures that:
/// 1  - parsing is successful
/// 2  - matches the expected output
/// 3a - actual progress log contains the given log message if [logMatches] is true
/// 3b - actual progress log does not contain the given log message if [logMatches] is false
void expectProgress(Parser grammar, String input, Object result, String log, [bool logMatches = true]) {
  _expectLog(progress, 'progress', grammar, input, result, log, logMatches);
}

void _expectLog(Function loggerFunction, String loggerName, Parser grammar, String input, Object result, String log, bool logMatches) {
  final sb = StringBuffer();
  WrapperParser p = loggerFunction(grammar, (obj) => sb.writeln(obj.toString()));
  final r = parse(input, p);
  expect(r.isSuccess, true);
  expect(r.value, result);
  var message = logMatches ?
  'Actual ' + loggerName + ' log does not contain expected log' :
  'Actual ' + loggerName + ' log does contain the unexpected log';
  message += '\n>> Expected: ' + log + '\n>> Actual: ' + sb.toString();
  expect(sb.toString().contains(log), logMatches, reason: message);
}
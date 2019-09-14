
import 'package:concisely/result/result.dart';
import 'package:test/test.dart';

void expectSuccess(Result r, Object expected) {
  expect(r.isSuccess, true, reason: r.toString());
  expect(r.value, expected);  
} 
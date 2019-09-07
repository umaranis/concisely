import 'package:concisely/result/result.dart';

class ParseException implements Exception {
  final Result result;

  const ParseException(this.result);
}
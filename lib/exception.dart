import 'package:dallang/result.dart';

class ParseException implements Exception {
  final Result result;

  const ParseException(this.result);
}
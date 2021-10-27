import 'package:concisely/src/result/result.dart';

class ParseException implements Exception {
  final Result result;

  const ParseException(this.result);
}

class GrammarMalformed implements Exception {
  String message;
  GrammarMalformed(this.message);
}
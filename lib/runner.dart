import 'dart:convert';

import 'package:dallang/context.dart';
import 'package:dallang/parser.dart';
import 'package:dallang/position.dart';
import 'package:dallang/result.dart';

import 'exception.dart';

T parseLinesOrThrow<T>(List<String> input, Parser parser) {
  var result = parser.parse(Context(input, Position.initial));
  if(result.isSuccess) {
    return result.value;
  }
  else {
    throw result;
  }
}

T parseOrThrow<T>(String input, Parser parser) {
  var lines = LineSplitter().convert(input);
  var result = parser.parse(Context(lines, Position.initial));
  if(result.isSuccess) {
    return result.value;
  }
  else {
    throw ParseException(result);
  }
}

Result parse(String input, Parser parser) {
  var lines = LineSplitter().convert(input);
  var result = parser.parse(Context(lines, Position.initial));
  return result;  
}




import 'dart:io';

import 'package:dallang/context.dart';
import 'package:dallang/position.dart';
import 'package:dallang/result.dart';

class Success<T> extends Result<T> {
  Success(Context context, this.value) : super(context);

  @override
  bool get isSuccess => true;

  @override
  final T value;

  @override
  String get message => null;

  @override
  String toString() => "Success[line:${context.pos.line + 1}, col:${context.pos.col + 1}] $value";

}
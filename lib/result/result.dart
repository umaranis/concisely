import 'package:dallang/context.dart';

abstract class Result<T> {
  Result(this.context);

  bool get isSuccess => false;
  bool get isFailure => false;

  String get message;

  T get value;

  final Context context; 

}
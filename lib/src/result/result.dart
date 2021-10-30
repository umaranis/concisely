import 'package:concisely/src/context.dart';

abstract class Result<T> {
  const Result(this.context);

  bool get isSuccess => false;
  bool get isFailure => false;

  String get message;

  T? get value;

  final Context context; 

}
import 'package:dallang/context.dart';
import 'package:dallang/result/result.dart';

class Failure<T> extends Result<T> {
  Failure(Context context, this.message) : super(context);

  @override
  bool get isFailure => true;

  @override  
  final String message;

  @override  
  T get value => null;

  @override
  toString() => "Failure[line:${context.pos.line + 1}, col:${context.pos.col + 1}] $message";

}
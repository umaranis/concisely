import 'package:conciseparser/context.dart';
import 'package:conciseparser/result/result.dart';

class Failure<T> extends Result<T> {
  Failure(Context context, this.message) : super(context);

  @override
  bool get isFailure => true;

  @override  
  final String message;

  @override  
  T get value => null;

  @override
  toString() => "Failure[pos:${context.pos + 1}] $message";

}
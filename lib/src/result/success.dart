
import 'package:concisely/src/context.dart';
import 'package:concisely/src/result/result.dart';

class Success<T> extends Result<T> {
  const Success(Context context, this.value) : super(context);

  @override
  bool get isSuccess => true;

  @override
  final T value;

  @override
  String get message => throw UnsupportedError("Successful parse doesn't have an error message.");

  @override
  String toString() => "Success[pos:${context.pos + 1}] $value"; 

}

import 'package:concisely/context.dart';
import 'package:concisely/result/result.dart';

class Success<T> extends Result<T> {
  const Success(Context context, this.value) : super(context);

  @override
  bool get isSuccess => true;

  @override
  final T value;

  @override
  String get message => null;

  @override
  String toString() => "Success[pos:${context.pos + 1}] $value"; 

}

import 'package:conciseparser/context.dart';
import 'package:conciseparser/result/result.dart';

class Success<T> extends Result<T> {
  Success(Context context, this.value) : super(context);

  @override
  bool get isSuccess => true;

  @override
  final T value;

  @override
  String get message => null;

  @override
  String toString() => "Success[pos:${context.pos + 1}] $value"; 

}
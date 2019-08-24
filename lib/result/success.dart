
import 'package:dallang/context.dart';
import 'package:dallang/result/result.dart';

class Success<T> extends Result<T> {
  Success(Context context, this.value) : super(context);

  @override
  bool get isSuccess => true;

  @override
  final T value;

  @override
  String get message => null;

  @override
  String toString() => "Success[line://TODO, col:${context.pos + 1}] $value"; // TODO: implement line number display

}
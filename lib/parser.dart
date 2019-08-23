import 'package:dallang/context.dart';
import 'package:dallang/result/result.dart';
import 'combinator/and.dart';
import 'combinator/times.dart';

abstract class Parser<T> {
  Result<T> parse(Context context);  

  Parser operator &(Parser other) => AndParser(this, other);
  Parser operator *(int times) => TimesParser(this, times);
}



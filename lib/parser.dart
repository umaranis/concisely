import 'package:dallang/and.dart';
import 'package:dallang/context.dart';
import 'package:dallang/result.dart';
import 'package:dallang/times.dart';

abstract class Parser<T> {
  Result<T> parse(Context context);  

  Parser operator &(Parser other) => AndParser(this, other);
  Parser operator *(int times) => TimesParser(this, times);
}



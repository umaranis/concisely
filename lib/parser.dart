import 'package:conciseparser/combinator/or.dart';
import 'package:conciseparser/context.dart';
import 'package:conciseparser/result/result.dart';
import 'combinator/and.dart';
import 'combinator/times.dart';

abstract class Parser<T> {
  Result<T> parse(Context context);  

  Parser operator &(Parser other) => AndParser(this, other);
  Parser operator *(int times) => TimesParser(this, times);
  Parser operator |(Parser other) => OrParser(this, other);
}



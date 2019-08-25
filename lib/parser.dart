import 'package:conciseparser/combinator/or.dart';
import 'package:conciseparser/context.dart';
import 'package:conciseparser/result/result.dart';
import 'package:conciseparser/times.dart/times.dart';
import 'combinator/and.dart';

abstract class Parser<T> {
  Result<T> parse(Context context);  

  Parser operator &(Parser other) => AndParser(this, other);
  Parser operator *(Object times) => timesFactory(this, times);
  Parser operator |(Parser other) => OrParser(this, other);
}



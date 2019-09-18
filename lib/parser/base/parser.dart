import 'package:concisely/context.dart';
import 'package:concisely/parser/combiner/and.dart';
import 'package:concisely/parser/combiner/or.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/times/times.dart';

abstract class Parser<T> {
  Result<T> parse(Context context);  

  Parser operator & (Parser other) => AndParser(this, other);
  Parser operator * (Object times) => timesFactory(this, times);
  Parser operator | (Parser other) => OrParser(this, other);
}



import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/result/failure.dart';
import 'package:concisely/result/result.dart';

class OrParser extends Parser {
  final Parser first, second;

  OrParser(this.first, this.second);

  @override
  Result parse(Context context) {
    final r1 = first.parse(context);
    if(r1.isSuccess) {
      return r1;
    }
    
    final r2 = second.parse(context);
    if(r2.isSuccess) {
      return r2;
    }
    
    return Failure(context, "${label} expected");
  }

  @override
  String get label => "${first.label} Or ${second.label}";

}


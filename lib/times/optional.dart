import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/context.dart';
import 'package:concisely/parser/base/times_parser.dart';
import 'package:concisely/result/result.dart';
import 'package:concisely/result/success.dart';

class OptionalParser extends TimesParser {
  
  OptionalParser(Parser parser) : super(parser);

  @override
  Result parse(Context context) {
    var r = parser.parse(context);
    if(r.isSuccess) {
      return r;
    }
    else {
      return Success(context, null);
    }    
  }

  @override
  String get label => '${parser.label} optional';
  
}
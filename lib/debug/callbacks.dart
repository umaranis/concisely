import 'package:concisely/context.dart';
import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/result/result.dart';

typedef void PreParse(PreParseContext c);
typedef void PostParse(PostParseContext c);
typedef void PreFastParse(PreFastParseContext c);
typedef void PostFastParse(PostFastParseContext c);

class Callbacks {

  final PreParse preParse;
  final PostParse postParse;
  final PreFastParse preFastParse;
  final PostFastParse postFastParse;

  Callbacks({this.preParse, this.postParse, this.preFastParse, this.postFastParse});
}

abstract class CallbackContext {
  final Parser parser;
  final Context preParseContext; 
  
  CallbackContext(this.parser, this.preParseContext);
}

class PreParseContext extends CallbackContext {  

  PreParseContext(Parser parser, Context context) 
    : super(parser, context);
}

class PostParseContext extends CallbackContext {
  final Result result;

  PostParseContext(Parser parser, Context preParseContext, this.result) 
    : super(parser, preParseContext);
}

class PreFastParseContext extends CallbackContext {
  final int pos; 

  PreFastParseContext(Parser parser, Context preParseContext, this.pos) : 
    super(parser, preParseContext);
}

class PostFastParseContext extends CallbackContext {
  final int initialPos;
  final int result;

  PostFastParseContext(Parser parser, Context preParseContext, this.initialPos, this.result) 
    : super(parser, preParseContext);  
}

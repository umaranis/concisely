import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/result/result.dart';

typedef PreParse = void Function(PreParseContext c);
typedef PostParse = void Function(PostParseContext c);
typedef PreFastParse = void Function(PreFastParseContext c);
typedef PostFastParse = void Function(PostFastParseContext c);

class Callbacks {

  final PreParse preParse;
  final PostParse postParse;
  final PreFastParse preFastParse;
  final PostFastParse postFastParse;

  Callbacks({required this.preParse, required this.postParse, required this.preFastParse, required this.postFastParse});
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

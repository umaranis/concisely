
import 'package:concisely/debug/callbacks.dart';
import 'package:concisely/debug/wrap.dart';
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/base/parser.dart';

WrapperParser progress(Parser p, [OutputHandler outputHandler = print]) {

  final c = Callbacks(
    preParse: (c) => outputHandler('${'*' * (c.preParseContext.pos + 1)} ${c.parser.runtimeType} called    [${c.parser.label}]'),
    postParse: (c) { },
    preFastParse: (c) => outputHandler('${'*' * (c.pos + 1)} ${c.parser.runtimeType} called    [${c.parser.label}]   <fast parse>'),
    postFastParse: (c) { } 
  );

  return wrap(p, c);

}

typedef void OutputHandler(Object object);


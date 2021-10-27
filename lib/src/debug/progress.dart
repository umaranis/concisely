import 'package:concisely/src/debug/callbacks.dart';
import 'package:concisely/src/debug/wrap.dart';
import 'package:concisely/src/debug/wrapper.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'output_handler.dart';

WrapperParser progress(Parser p, [OutputHandler outputHandler = print]) {

  final c = Callbacks(
    preParse: (c) => outputHandler('${'*' * (c.preParseContext.pos + 1)} ${c.parser.runtimeType} called    [${c.parser.name}]'),
    postParse: (c) { },
    preFastParse: (c) => outputHandler('${'*' * (c.pos + 1)} ${c.parser.runtimeType} called    [${c.parser.name}]   <fast parse>'),
    postFastParse: (c) { } 
  );

  return wrap(p, c);

}
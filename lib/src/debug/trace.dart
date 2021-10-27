import 'package:concisely/src/debug/callbacks.dart';
import 'package:concisely/src/debug/wrap.dart';
import 'package:concisely/src/debug/wrapper.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'output_handler.dart';

WrapperParser trace(Parser p, [OutputHandler outputHandler = print]) {
  int level = 0;
  final c = Callbacks(
    preParse: (c) => outputHandler('${'  ' * (level++)}${c.parser.runtimeType}  [${c.parser.name}]'),
    postParse: (c) => outputHandler('${'  ' * --level}${c.result.isSuccess?"Success":"Failure"}[${c.result.context.pos}]: ${c.result.isSuccess?c.result.value:c.result.message}'),
    preFastParse: (c) => outputHandler('${'  ' * (level++)}${c.parser.runtimeType}  [${c.parser.name}]   <fast parse>'),
    postFastParse: (c) => outputHandler('${'  ' * --level}${c.result != -1?"Success":"Failure"}[${c.result != -1?c.result:c.initialPos}]:'), 
  );

  return wrap(p, c);

}
import 'package:concisely/debug/wrapper.dart';
import 'package:concisely/parser/base/parser.dart';
import 'callbacks.dart';

WrapperParser wrap(Parser parser, Callbacks c) { 

  for (var child in parser.children) {
    parser.replace(child, WrapperParser(child, c));
    wrap(child, c);
  }

  return WrapperParser(parser, c);
}
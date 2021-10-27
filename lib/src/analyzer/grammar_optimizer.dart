import 'package:concisely/src/analyzer/traverse.dart';
import 'package:concisely/src/parser/base/parent_parser.dart';
import 'package:concisely/src/parser/base/parser.dart';

/// Remove a all occurrences of given type of parent parser
/// `PA -> PB -> PC -> PB -> PD`  removing PB gives  `PA -> PC -> PD`
void removeParentParserFromStructure(Parser grammar, Type typeToRemove) {
  grammar.forEach((p) => {
    p.children.forEach((child) {
       if(child.runtimeType == typeToRemove && child is ParentParser) {
         p.replace(child, child.parser);
       }
    })
  });
}
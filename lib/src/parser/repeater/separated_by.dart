import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/combiner/space_trimming_sequence.dart';
import 'package:concisely/src/parser/repeater/times.dart';
import 'package:concisely/src/parser/string/str.dart';
import 'package:concisely/src/parser/transformer/skip_null_transformer.dart';
import 'package:concisely/src/parser/transformer/skip_transformer.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/parser/transformer/trimming_parser.dart';

import '../../../concisely.dart';

extension SeparatedByExtensions on Parser {

  /// parsers a list of item separated by the given separator.
  /// Ignores whitespace on either side of the separator.
  /// Whitespaces and separators are not included in the output
  ///
  /// [separator] String or Parser specifying the separator
  ///
  /// Example:
  ///     digit.many.separatedBy(',') - parses '1, 2, 3' to a list of 3 digits (without separators)
  Parser separatedBy(Object separator, [bool optionalSeparatorAtEnd = false]) {
    Parser sepParser;
    if(separator is String) {
      sepParser = str(separator);
    }
    else if(separator is Parser) {
      sepParser = separator;
    }
    else {
      throw ArgumentError("'separator' argument should be of type Parser or String for 'separatedBy' method.", "separatedBy");
    }

    Parser grammar = this + (sepParser + this.trim).pick(1).zeroOrMore.skipNull;
    if(optionalSeparatorAtEnd) {
      grammar += sepParser.optional.skip;
    }

    grammar = grammar >
        map((result) {
          if (result is List) {
            if (result.length == 2) {
              List list2 = result.removeAt(1);
              result.addAll(list2);
            }
          }
          return result;
        });

    return grammar;



  }
}
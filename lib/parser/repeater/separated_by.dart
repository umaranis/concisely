import 'package:concisely/parser/base/parser.dart';
import 'package:concisely/parser/combiner/space_trimming_sequence.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:concisely/parser/text/text.dart';
import 'package:concisely/parser/transformer/skip_transformer.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/transformer/trimming_parser.dart';

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
      sepParser = text(separator);
    }
    else if(separator is Parser) {
      sepParser = separator;
    }
    else {
      throw ArgumentError("'separator' argument should be of type Parser or String for 'separatedBy' method.", "separatedBy");
    }
    return this + (sepParser.skip + this.trim).zeroOrMore + sepParser.optional.skip > type.list;
  }
}
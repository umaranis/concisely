import 'package:concisely/executor.dart';
import 'package:concisely/parser/transformer/transformer.dart';
import 'package:concisely/parser/char/eof.dart';
import 'package:concisely/parser/char/letter.dart';
import 'package:concisely/parser/repeater/times.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {
  group('convert to bool', () {
    final boolean = letter.many & eof  > type.bool;

    test('true', () {
      expectParse(boolean,
          'true',
          true);
    });

    test('false', () {
      expectParse(boolean,
          'false',
          false);
    });

    test('False', () {
      expectParse(boolean,
          'false',
          false);
    });

    test('true1', () {
      expectFailure(parse('true1', boolean));
    });

  });

}

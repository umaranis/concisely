import 'package:concisely/concisely.dart';
import 'package:test/test.dart';
import '../../helper.dart';

void main() {
  group('convert to bool', () {
    final boolean = letter.many & eof  > toBool;

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

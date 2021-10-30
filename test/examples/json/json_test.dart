import 'package:concisely/debug.dart';
import 'package:test/test.dart';

import '../../expect_parse_helper.dart';
import 'json.dart';

void main() {
  final grammar = getJsonGrammar();

  group('arrays', () {
    test('empty', () {
      expectParse.pass(grammar, '[]', []);
    });
    test('small', () {
      expectParse.pass(grammar, '["a"]', ['a']);
    });
    test('large', () {
      expectParse.pass(grammar, '["a", "b", "c"]', ['a', 'b', 'c']);
    });
    test('nested', () {
      expectParse.pass(grammar, '[["a"]]', [['a']]);
    });
    test('invalid', () {
      expectParse.fail(grammar, '[');
      expectParse.fail(grammar, '[1');
      expectParse.fail(grammar, '[1,');
      expectParse.fail(grammar, '[1,]');
      expectParse.fail(grammar, '[1 2]');
      expectParse.fail(grammar, '[]]');
    });
  group('objects', () {
    test('empty', () {
      expectParse.pass(grammar, '{}', {});
    });
    test('small', () {
      expectParse.pass(grammar, '{"a": 1}', {'a': 1});
    });
    test('large', () {
      expectParse.pass(grammar, '{"a": 1, "b": 2, "c": 3}',
          {'a': 1, 'b': 2, 'c': 3});
    });
    test('nested', () {
      expectParse.pass(grammar, '{"obj": {"a": 1}}', {
        'obj': {'a': 1}
      });
    });
    test('invalid', () {
      expectParse.fail(grammar, '{');
      expectParse.fail(grammar, "{'a'");
      expectParse.fail(grammar, "{'a':");
      expectParse.fail(grammar, "{'a':'b'");
      expectParse.fail(grammar, "{'a':'b',");
      expectParse.fail(grammar, "{'a'}");
      expectParse.fail(grammar, "{'a':}");
      expectParse.fail(grammar, "{'a':'b',}");
      expectParse.fail(grammar, '{}}');
    });
  });
  group('literals', () {
    test('valid true', () {
      expectParse.pass(grammar, 'true', true);
    });
    test('invalid true', () {
      expectParse.fail(grammar, 'tr');
      expectParse.fail(grammar, 'trace');
      expectParse.fail(grammar, 'truest');
    });
    test('valid false', () {
      expectParse.pass(grammar, 'false', false);
    });
    test('invalid false', () {
      expectParse.fail(grammar, 'fa');
      expectParse.fail(grammar, 'falsely');
      expectParse.fail(grammar, 'fabulous');
    });
    test('valid null', () {
      expectParse.pass(grammar, 'null', null);
    });
    test('invalid null', () {
      expectParse.fail(grammar, 'nu');
      expectParse.fail(grammar, 'nuclear');
      expectParse.fail(grammar, 'nullified');
    });
    test('valid integer', () {
      expectParse.pass(grammar, '0', 0);
      expectParse.pass(grammar, '1', 1);
      expectParse.pass(grammar, '-1', -1);
      expectParse.pass(grammar, '12', 12);
      expectParse.pass(grammar, '-12', -12);
      expectParse.pass(grammar, '1e2', 100);
      expectParse.pass(grammar, '1e+2', 100);
    });
    test('invalid integer', () {
      expectParse.fail(grammar, '00');
      expectParse.fail(grammar, '01');
    });
    test('valid float', () {
      expectParse.pass(grammar, '0.0', 0.0);
      expectParse.pass(grammar, '0.12', 0.12);
      expectParse.pass(grammar, '-0.12', -0.12);
      expectParse.pass(grammar, '12.34', 12.34);
      expectParse.pass(grammar, '-12.34', -12.34);
      expectParse.pass(grammar, '1.2e-1', 1.2e-1);
      expectParse.pass(grammar, '1.2E-1', 1.2e-1);
    });
    test('invalid float', () {
      expectParse.fail(grammar, '.1');
      expectParse.fail(grammar, '0.1.1');
    });
   test('plain string', () {
      expectParse.pass(grammar, '""', '');
      expectParse.pass(grammar, '"foo"', 'foo');
      expectParse.pass(grammar, '"foo bar"', 'foo bar');
    });
    test('escaped string', () {
      expectParse.pass(grammar, '"\\""', '"');
      expectParse.pass(grammar, '"\\\\"', '\\');
      expectParse.pass(grammar, '"\\b"', '\b');
      expectParse.pass(grammar, '"\\f"', '\f');
      expectParse.pass(grammar, '"\\n"', '\n');
      expectParse.pass(grammar, '"\\r"', '\r');
      expectParse.pass(grammar, '"\\t"', '\t');
    });
    test('unicode string', () {
      expectParse.pass(grammar, '"\\u0030"', '0');
      expectParse.pass(grammar, '"\\u007B"', '{');
      expectParse.pass(grammar, '"\\u007d"', '}');
    });
    test('invalid string', () {
      expectParse.fail(trace(grammar), '"');
      expectParse.fail(grammar, '"a');
      expectParse.fail(grammar, '"a\\"');
      expectParse.fail(grammar, '"\\u00"');
      expectParse.fail(grammar, '"\\u000X"');
    });
   });
  // group('browser', () {
  //   test('Internet Explorer', () {
  //     const input = '{"recordset": null, "type": "change", '
  //         '"fromElement": null, "toElement": null, "altLeft": false, '
  //         '"keyCode": 0, "repeat": false, "reason": 0, "behaviorCookie": 0, '
  //         '"contentOverflow": false, "behaviorPart": 0, "dataTransfer": null, '
  //         '"ctrlKey": false, "shiftLeft": false, "dataFld": "", '
  //         '"qualifier": "", "wheelDelta": 0, "bookmarks": null, "button": 0, '
  //         '"srcFilter": null, "nextPage": "", "cancelBubble": false, "x": 89, '
  //         '"y": 502, "screenX": 231, "screenY": 1694, "srcUrn": "", '
  //         '"boundElements": {"length": 0}, "clientX": 89, "clientY": 502, '
  //         '"propertyName": "", "shiftKey": false, "ctrlLeft": false, '
  //         '"offsetX": 25, "offsetY": 2, "altKey": false}';
  //     expect(grammar.parse(input).isSuccess, isTrue);
  //     expectParse.pass(grammar, input).isSuccess, isTrue);
  //   });
  //   test('FireFox', () {
  //     const input = '{"type": "change", "eventPhase": 2, "bubbles": true, '
  //         '"cancelable": true, "timeStamp": 0, "CAPTURING_PHASE": 1, '
  //         '"AT_TARGET": 2, "BUBBLING_PHASE": 3, "isTrusted": true, '
  //         '"MOUSEDOWN": 1, "MOUSEUP": 2, "MOUSEOVER": 4, "MOUSEOUT": 8, '
  //         '"MOUSEMOVE": 16, "MOUSEDRAG": 32, "CLICK": 64, "DBLCLICK": 128, '
  //         '"KEYDOWN": 256, "KEYUP": 512, "KEYPRESS": 1024, "DRAGDROP": 2048, '
  //         '"FOCUS": 4096, "BLUR": 8192, "SELECT": 16384, "CHANGE": 32768, '
  //         '"RESET": 65536, "SUBMIT": 131072, "SCROLL": 262144, "LOAD": 524288, '
  //         '"UNLOAD": 1048576, "XFER_DONE": 2097152, "ABORT": 4194304, '
  //         '"ERROR": 8388608, "LOCATE": 16777216, "MOVE": 33554432, '
  //         '"RESIZE": 67108864, "FORWARD": 134217728, "HELP": 268435456, '
  //         '"BACK": 536870912, "TEXT": 1073741824, "ALT_MASK": 1, '
  //         '"CONTROL_MASK": 2, "SHIFT_MASK": 4, "META_MASK": 8}';
  //     expect(grammar.parse(input).isSuccess, isTrue);
  //     expectParse.pass(grammar, input).isSuccess, isTrue);
  //   });
  //   test('WebKit', () {
  //     const input = '{"returnValue": true, "timeStamp": 1226697417289, '
  //         '"eventPhase": 2, "type": "change", "cancelable": false, '
  //         '"bubbles": true, "cancelBubble": false, "MOUSEOUT": 8, '
  //         '"FOCUS": 4096, "CHANGE": 32768, "MOUSEMOVE": 16, "AT_TARGET": 2, '
  //         '"SELECT": 16384, "BLUR": 8192, "KEYUP": 512, "MOUSEDOWN": 1, '
  //         '"MOUSEDRAG": 32, "BUBBLING_PHASE": 3, "MOUSEUP": 2, '
  //         '"CAPTURING_PHASE": 1, "MOUSEOVER": 4, "CLICK": 64, "DBLCLICK": 128, '
  //         '"KEYDOWN": 256, "KEYPRESS": 1024, "DRAGDROP": 2048}';
  //     expect(grammar.parse(input).isSuccess, isTrue);
  //     expectParse.pass(grammar, input).isSuccess, isTrue);
  //   });
  // });
  // group('issues', () {
  //   group('https://github.com/petitparser/dart-petitparser/issues/98', () {
  //     test('expected some value', () {
  //       const invalid = '';
  //       final result = grammar.parse(invalid);
  //       expect(result.isFailure, isTrue);
  //       expect(result.position, 0);
  //       expect(
  //           result.message,
  //           'Expected string OR Expected number OR Expected { OR '
  //               'Expected [ OR Expected true OR Expected false OR '
  //               'Expected null');
  //     });
  //     test('expected closing curly', () {
  //       const invalid = '{"a": "bad "value" string"}';
  //       final result = grammar.parse(invalid);
  //       expect(result.isFailure, isTrue);
  //       expect(result.position, 12);
  //       expect(result.message, 'Expected }');
  //     });
  //   });
  });
}

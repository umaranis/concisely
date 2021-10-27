import 'package:concisely/concisely.dart';

Parser getJsonGrammar() {

  const Map<String, String> jsonEscapeChars = {
    '\\': '\\',
    '/': '/',
    '"': '"',
    'b': '\b',
    'f': '\f',
    'n': '\n',
    'r': '\r',
    't': '\t'
  };

  var characterNormal = except('"\\');
  var characterEscape = char('\\') & char(jsonEscapeChars.keys.join())
      > map((result) => jsonEscapeChars[result[1]]);
  var characterUnicode = str('\\u') & char('0-9A-Fa-f').times(4);
  var characterPrimitive = characterNormal | characterEscape | characterUnicode;
  var stringToken = char('"').skip & characterPrimitive.zeroOrMore & char('"').skip
      > toStr;

  var numberToken =
      char('-').optional &
      (char('0') | digit.many) &
      (char('.') & digit.many).optional &
      (char('eE') & char('-+').optional & digit.many).optional
          > toFloat;

  var booleanToken = str('true') | str('false')
      > toBool;

  var nullToken = str('null')
      > map((r) => null);

  var value = ref; // recursive rule

  var pair = stringToken + char(':') + value;
  var members = pair.separatedBy(',');
  var object = char('{') + members.optional + char('}')
      > map((each) {
        final result = {};
        if (each[1] != null) {
          for (final element in each[1]) {
            result[element[0]] = element[2];
          }
        }
        return result;
      });;

  var elements = value.separatedBy(',');
  var array = char('[') + elements.optional + char(']')
      > map((result) => result[1] ?? []);

  value.p = stringToken | numberToken | object | array | booleanToken | nullToken;

  return value;
}


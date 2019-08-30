import 'package:conciseparser/context.dart';
import 'package:conciseparser/fastParser.dart';
import 'package:conciseparser/result/failure.dart';
import 'package:conciseparser/result/result.dart';
import 'package:conciseparser/result/success.dart';

CharParser char(Object charCode) {
  return CharParser(charCode);
}

class CharParser extends FastParser<String>{
  final int charCode;  

  CharParser(Object char) : this.charCode = toCharCode(char);

  @override
  Result<String> parse(Context context) {
    int next = context.seek();
    if (charCode == next) {
      return Success(context.move(1), String.fromCharCode(charCode));
    }
    return Failure(context, '"${toReadableString(charCode)}" expected');
  }
  
  @override
  int fastParse(Context context, int offset) {
    int next = context.seek(offset);
    if (charCode == next) {
      return offset + 1;
    }    
    return -1;    
  }

  @override
  String getFastParseResult(Context context, int initialOffset, int resultPosition) {
    return String.fromCharCode(charCode);
  }

  @override
  String getFastParseMessage() {
    return String.fromCharCode(charCode);    
  }
}

/// Converts an object to a character code.
int toCharCode(Object element) {
  if (element is num) {
    return element.round();
  }
  final value = element.toString();
  if (value.length != 1) {
    throw ArgumentError('"$value" is not a character');
  }
  return value.codeUnitAt(0);
}

/// Converts a character to a readable string.
String toReadableString(Object element) {
  if (element is String && element.length > 1) {
    final buffer = StringBuffer();
    for (var i = 0; i < element.length; i++) {
      buffer.write(toReadableString(element[i]));
    }
    return buffer.toString();
  }
  final code = toCharCode(element);
  switch (code) {
    case 0x08:
      return '\\b'; // backspace
    case 0x09:
      return '\\t'; // horizontal tab
    case 0x0A:
      return '\\n'; // new line
    case 0x0B:
      return '\\v'; // vertical tab
    case 0x0C:
      return '\\f'; // form feed
    case 0x0D:
      return '\\r'; // carriage return
    case 0x22:
      return '\\"'; // double quote
    case 0x27:
      return "\\'"; // single quote
    case 0x5C:
      return '\\\\'; // backslash
  }
  if (code < 0x20) {
    return '\\x${code.toRadixString(16).padLeft(2, '0')}';
  }
  return String.fromCharCode(code);
}

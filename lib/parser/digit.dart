import 'package:conciseparser/context.dart';
import 'package:conciseparser/fastParser.dart';
import 'package:conciseparser/result/failure.dart';
import 'package:conciseparser/result/result.dart';
import 'package:conciseparser/result/success.dart';

final DigitParser digit = DigitParser();

class DigitParser extends FastParser<String>{

  @override
  Result<String> parse(Context context) {
    int value = context.seek();
    if (48 <= value && value <= 57) {
      return Success(context.move(1), String.fromCharCode(value));
    }
    return Failure(context, 'digit expected');
  }
  
  @override
  int fastParse(Context context, int offset) {
    int value = context.seek(offset);
    if (48 <= value && value <= 57) {
      return offset + 1;
    }    
    return -1;    
  }

  @override
  String getFastParseResult(Context context, int initialOffset, int resultPosition) {
    return String.fromCharCode(context.seek(initialOffset));
  }

  @override
  String getFastParseMessage() {
    return "digit";    
  }
}


import 'package:conciseparser/parser/char/char.dart';
import 'package:conciseparser/times.dart/times.dart';

final newline = char('\n') 
                | 
                ( char('\r') & char('\n') * optional );
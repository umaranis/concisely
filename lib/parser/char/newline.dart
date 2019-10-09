import 'package:concisely/parser/char/char.dart';
import 'package:concisely/parser/times/times.dart';

final newline = char('\n') 
                | 
                ( char('\r') & char('\n') * optional );
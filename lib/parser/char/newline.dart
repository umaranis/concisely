import 'package:concisely/parser/char/char.dart';
import 'package:concisely/times.dart/times.dart';

final newline = char('\n') 
                | 
                ( char('\r') & char('\n') * optional );
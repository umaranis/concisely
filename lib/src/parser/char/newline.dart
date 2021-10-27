import 'package:concisely/src/parser/char/char.dart';
import 'package:concisely/src/parser/repeater/times.dart';

/// matches newline
final newline = char('\n') 
                | 
                ( char('\r') & char('\n') * optional );
import 'package:dallang/position.dart';

class Context {
  final List<String> input;
  final Position pos;

  const Context(this.input, this.pos);  

  String get line => input[pos.line];

  bool colExists(num col) => line.length > col;

  int getCharCode(int col) => line.codeUnitAt(col);  

  Context moveCol(int number)  {
    return Context(input, Position(pos.line, pos.col + number, pos.indent));
  }
  
}



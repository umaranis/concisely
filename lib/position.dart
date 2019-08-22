class Position {
  final int line;
  final int col;
  final int indent;

  const Position(this.line, this.col, this.indent);

  static const initial = Position(0, 0, 0);
}
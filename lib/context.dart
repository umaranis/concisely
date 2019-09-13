class Context {
  final String _input;
  final int pos;
  
  const Context(this._input, this.pos);  

  int seek([int forward = 0]) {
    int position = this.pos + forward;
    if(position < _input.length) {
      return _input.codeUnitAt(position);
    }
    else {
      return EOF;
    }
  }

  Context move(int number)  {
    return Context(_input, pos + number);
  }

  /// Returns subString of the input source, from the current [pos] till [endPosition]
  String substring(int endPosition) {
    return _input.substring(pos, pos+ endPosition);
  } 

  /// Returns subString of the input source, starting from an [offset] from the current [pos].
  /// [length] is the number of characters to include in the subString.
  String subStringFromOffset(int offset, int length) {
    final startPos = pos + offset;
    return _input.substring(startPos, startPos + length);
  }
  
  static const int EOF = 0x1A;
}



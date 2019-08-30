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

  String substring(int offset) {
    return _input.substring(pos, pos + offset);
  } 
  
  static const int EOF = 0x1A;
}



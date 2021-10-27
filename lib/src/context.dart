class Context {
  final String _input;
  final int pos;
  
  const Context(this._input, this.pos);  

  int seek([int offset = 0]) {
    int position = this.pos + offset;
    if(position < _input.length) {
      return _input.codeUnitAt(position);
    }
    else {
      return EOF;
    }
  }

    int seekAt(int position) {    
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

  Context moveTo(int pos) {
    return Context(_input, pos);
  } 

  /// Returns subString of the input source, from the current [pos] till [endPosition]
  String substring(int endPosition) {
    return _input.substring(pos, pos + endPosition);
  } 

  /// Returns subString of the input source based on [start] and [end] position. 
  /// This is irrespective of the current [pos].  
  String subStringFromOffset(int start, int end) {    
    return _input.substring(start, end);
  }
  
  static const int EOF = 0x1A;
}
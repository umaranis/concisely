import 'package:concisely/src/parser/base/parser.dart';

typedef Action = void Function(Parser parser);
typedef Condition = bool Function(Parser p);
/// [parser] parser to perform action on <br/>
/// [level] depth of parser in grammar structure
typedef Action2 = void Function(Parser parser, int level);

extension TraversalExtensions on Parser {
  void forEach(Action action) {
    _forEach(this, action, {});
  }

  /// The action call has one extra argument which is the depth the parser
  void forEach2(Action2 action) {
    _forEach2(this, action, {}, 0);
  }

  List<Parser> where(Condition condition) {
    List<Parser> list = [];
    this.forEach((parser) {
      if(condition(parser)) {
        list.add(parser);
      }
    });

    return list;
  }

  void printHierarchy() {
    _printHierarchy(this, {}, 0);
  }
}


void _forEach(Parser p, Action action, Set seen) {
  if(seen.add(p)) {
    action(p);
    if(!p.children.isEmpty) {
      for (var e in p.children) {
        _forEach(e, action, seen);
      }
    }
  }
}

void _forEach2(Parser p, Action2 action, Set seen, int i) {
  if(seen.add(p)) {
    action(p, i);
    if(!p.children.isEmpty) {
      i++;
      for (var e in p.children) {
        _forEach2(e, action, seen, i);
      }
    }
  }
}

/// TODO: seems to be flawed. Assumes anything with no children but appearing again is recursive (counter example is newline)
void _printHierarchy(Parser p, Set seen, int i) {
  if(seen.add(p) || p.children.isEmpty) {
    print('${' ' * i}$p        - ${p.children.length} children(${p.children.map((c) => c.runtimeType.toString()).join(',') }) - #${p.hashCode} ');
    i++;
    for (var e in p.children) {
      _printHierarchy(e, seen, i);
    }
  }
  else {
    print('${' ' * i}<rec>$p - ${p.children.length} children - #${p.hashCode} ');
  }
}


import 'package:collection/src/list_extensions.dart';
import 'package:concisely/src/context.dart';
import 'package:concisely/src/parser/base/parser.dart';
import 'package:concisely/src/parser/combiner/sequence.dart';
import 'package:concisely/src/parser/transformer/transformer.dart';
import 'package:concisely/src/parser/other/failure_parser.dart';
import 'package:concisely/src/result/failure.dart';
import 'package:concisely/src/result/output_type.dart';
import 'package:concisely/src/result/result.dart';
import 'package:concisely/src/result/success.dart';

/// Transforms the result of a successful parse that by returning the element at a given index of a list.
class PickOneTransformer extends Transformer {
  final int index;

  PickOneTransformer(Parser parser, this.index) : super(parser);

  @override
  String get name => 'Pick Transformer (index: ${index})';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var result = parser.parse(context);
    if(result.isSuccess) {
      if(result.value is List) {
        return Success(result.context, result.value[index]);
      }
      else {
        return Failure(context, "pick($index) failed because '${result.value}' is not a list.");
      }
    }
    else {
      return result;
    }
  }

  @override
  bool hasEqualProperties(PickOneTransformer other) => this.index == other.index;
}

/// Transforms the result of a successful parse that by returning the elements at given indexes of a list.
/// @throws RangeError if given index is out of bound
class PickManyTransformer extends Transformer {
  final List<int> indexes;
  PickManyTransformer(Parser parser, this.indexes) : super(parser);

  @override
  String get name => 'Pick Transformer (index: ${indexes})';

  @override
  Result parse(Context context, [OutputType outputType = OutputType.tree]) {
    var result = parser.parse(context);
    if(result.isSuccess) {
      if(result.value is List) {
        List valList = []..length = indexes.length;

        for (int i = 0; i < valList.length; i++) {
          valList[i] = result.value[indexes[i]];
        }

        return Success(result.context, valList);
      }
      else {
        return Failure(context, "pick($indexes) failed because '${result.value}' is not a list.");
      }
    }
    else {
      return result;
    }
  }

  @override
  bool hasEqualProperties(PickManyTransformer other) => this.indexes.equals(other.indexes);
  
}

List<int> convert(int i1, [int? i2, int? i3, int? i4, int? i5, int? i6, int? i7, int? i8, int? i9, int? i10]) {
  var indexSet = {i1};
  if(i2 != null) indexSet.add(i2);
  if(i3 != null) indexSet.add(i3);
  if(i4 != null) indexSet.add(i4);
  if(i5 != null) indexSet.add(i5);
  if(i6 != null) indexSet.add(i6);
  if(i7 != null) indexSet.add(i7);
  if(i8 != null) indexSet.add(i8);
  if(i9 != null) indexSet.add(i9);
  if(i10 != null) indexSet.add(i10);

  List<int> indexes = indexSet.toList(growable: false);
  indexes.sort();

  return indexes;
}

extension PickExtension on SequenceParser {
  /// Transforms the result of a successful parse by returning the elements at given indexes of a list.
  ///
  /// @returns Results of pick transform are returned in an array if multiple indexes are given, otherwise just a single value is returned. <br/>
  /// @throws RangeError if given index is out of bound
  ///
  /// Examples:
  ///
  ///     grammar: digit & char('*') & digit > pick(0,2)
  ///     input: '2*4'
  ///     result: ['2','4']
  ///
  ///     grammar: digit & char('*') & digit > pick(0)
  ///     input: '2*4'
  ///     result: '2'
  Transformer pick(int i1, [int? i2, int? i3, int? i4, int? i5, int? i6, int? i7, int? i8, int? i9, int? i10]) {
    return _pick(this, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10);
  }
}

/// Transforms the result of a successful parse by returning the elements at given indexes of a list.
///
/// @returns Results of pick transform are returned in an array if multiple indexes are given, otherwise just a single value is returned. <br/>
/// @throws RangeError if given index is out of bound
///
/// Examples:
///
///     grammar: digit & char('*') & digit > pick(0,2)
///     input: '2*4'
///     result: ['2','4']
///
///     grammar: digit & char('*') & digit > pick(0)
///     input: '2*4'
///     result: '2'
Transformer pick(int i1, [int? i2, int? i3, int? i4, int? i5, int? i6, int? i7, int? i8, int? i9, int? i10]) {
  return _pick(ConstantFailureParser(), i1, i2, i3, i4, i5, i6, i7, i8, i9, i10);
}

Transformer _pick(Parser p, int i1, [int? i2, int? i3, int? i4, int? i5, int? i6, int? i7, int? i8, int? i9, int? i10]) {
  var indexes = convert(i1, i2, i3, i4, i5, i6, i7, i8, i9, i10);
  if(indexes.length == 1) {
    return PickOneTransformer(p, indexes[0]);
  }
  else {
    return PickManyTransformer(p, indexes);
  }
}

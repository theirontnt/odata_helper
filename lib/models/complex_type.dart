import 'package:json_annotation/json_annotation.dart';

import '../decoder.dart';
import 'entity.dart';
import '../keywords.dart' as kw;

part "complex_type.g.dart";

@JsonSerializable(anyMap: true)
class ComplexType extends Entity {
  ComplexType(String name, JSON json) : super(name, json) {
    if (runtimeType is ComplexType && json[kw.kind] != kw.complexTypeKind) {
      throw "Complex type must be of ${kw.complexTypeKind} kind";
    }
  }

  static ComplexType fromJson(JSON json) => _$ComplexTypeFromJson(json);

  @override
  JSON toJson() => _$ComplexTypeToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../decoder.dart';

part "enum_type_value.g.dart";

@JsonSerializable(anyMap: true, genericArgumentFactories: true)
class EnumTypeValue<T> {
  final String name;

  final T value;

  const EnumTypeValue(this.name, this.value);

  factory EnumTypeValue.fromJson(JSON json, T Function(Object? json) fromJsonT) => _$EnumTypeValueFromJson(json, fromJsonT);

  JSON toJson(Object Function(T value) toJsonT) => _$EnumTypeValueToJson(this, toJsonT);
}

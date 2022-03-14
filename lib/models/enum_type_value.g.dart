// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_type_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumTypeValue<T> _$EnumTypeValueFromJson<T>(
  Map json,
  T Function(Object? json) fromJsonT,
) =>
    EnumTypeValue<T>(
      json['name'] as String,
      fromJsonT(json['value']),
    );

Map<String, dynamic> _$EnumTypeValueToJson<T>(
  EnumTypeValue<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'name': instance.name,
      'value': toJsonT(instance.value),
    };

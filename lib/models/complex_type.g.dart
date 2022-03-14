// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplexType _$ComplexTypeFromJson(Map json) => ComplexType(
      json['name'] as String,
      Map<String, dynamic>.from(json['json'] as Map),
    )
      ..key = json['key']
      ..openType = json['openType'] as bool
      ..isAbstract = json['isAbstract'] as bool
      ..hasStream = json['hasStream'] as bool
      ..baseType = json['baseType'] as String?;

Map<String, dynamic> _$ComplexTypeToJson(ComplexType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'json': instance.json,
      'key': instance.key,
      'openType': instance.openType,
      'isAbstract': instance.isAbstract,
      'hasStream': instance.hasStream,
      'baseType': instance.baseType,
    };

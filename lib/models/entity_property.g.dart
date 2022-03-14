// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntityProperty _$EntityPropertyFromJson(Map json) => EntityProperty(
      json['name'] as String,
      Map<String, dynamic>.from(json['json'] as Map),
    )
      ..type = json['type']
      ..collection = json['collection'] as bool
      ..nullable = json['nullable'] as bool
      ..maxLength = json['maxLength'] as int?
      ..unicode = json['unicode'] as bool
      ..precision = json['precision'] as int?
      ..scale = json['scale']
      ..defaultValue = json['defaultValue'];

Map<String, dynamic> _$EntityPropertyToJson(EntityProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'json': instance.json,
      'type': instance.type,
      'collection': instance.collection,
      'nullable': instance.nullable,
      'maxLength': instance.maxLength,
      'unicode': instance.unicode,
      'precision': instance.precision,
      'scale': instance.scale,
      'defaultValue': instance.defaultValue,
    };

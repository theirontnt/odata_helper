// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationProperty _$NavigationPropertyFromJson(Map json) => NavigationProperty(
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
      ..defaultValue = json['defaultValue']
      ..partner = json['partner']
      ..containsTarget = json['containsTarget'] as bool
      ..referentialConstraint = json['referentialConstraint'];

Map<String, dynamic> _$NavigationPropertyToJson(NavigationProperty instance) =>
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
      'partner': instance.partner,
      'containsTarget': instance.containsTarget,
      'referentialConstraint': instance.referentialConstraint,
    };

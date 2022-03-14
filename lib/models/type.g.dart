// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeDefinition _$TypeDefinitionFromJson(Map json) => TypeDefinition(
      json['name'] as String,
      Map<String, dynamic>.from(json['json'] as Map),
    )
      ..underlyingType = $enumDecode(_$EdmTypeEnumMap, json['underlyingType'])
      ..maxLength = json['maxLength'] as int?
      ..unicode = json['unicode'] as bool
      ..precision = json['precision'] as int?
      ..scale = json['scale'];

Map<String, dynamic> _$TypeDefinitionToJson(TypeDefinition instance) =>
    <String, dynamic>{
      'name': instance.name,
      'json': instance.json,
      'underlyingType': _$EdmTypeEnumMap[instance.underlyingType],
      'maxLength': instance.maxLength,
      'unicode': instance.unicode,
      'precision': instance.precision,
      'scale': instance.scale,
    };

const _$EdmTypeEnumMap = {
  EdmType.Binary: 'Binary',
  EdmType.Boolean: 'Boolean',
  EdmType.Byte: 'Byte',
  EdmType.Date: 'Date',
  EdmType.DateTimeOffset: 'DateTimeOffset',
  EdmType.Decimal: 'Decimal',
  EdmType.Double: 'Double',
  EdmType.Duration: 'Duration',
  EdmType.Guid: 'Guid',
  EdmType.Int16: 'Int16',
  EdmType.Int32: 'Int32',
  EdmType.Int64: 'Int64',
  EdmType.SByte: 'SByte',
  EdmType.Single: 'Single',
  EdmType.Stream: 'Stream',
  EdmType.String: 'String',
  EdmType.TimeOfDay: 'TimeOfDay',
  EdmType.Geography: 'Geography',
  EdmType.GeographyPoint: 'GeographyPoint',
  EdmType.GeographyLineString: 'GeographyLineString',
  EdmType.GeographyPolygon: 'GeographyPolygon',
  EdmType.GeographyMultiPoint: 'GeographyMultiPoint',
  EdmType.GeographyMultiLineString: 'GeographyMultiLineString',
  EdmType.GeographyMultiPolygon: 'GeographyMultiPolygon',
  EdmType.GeographyCollection: 'GeographyCollection',
  EdmType.Geometry: 'Geometry',
  EdmType.GeometryPoint: 'GeometryPoint',
  EdmType.GeometryLineString: 'GeometryLineString',
  EdmType.GeometryPolygon: 'GeometryPolygon',
  EdmType.GeometryMultiPoint: 'GeometryMultiPoint',
  EdmType.GeometryMultiLineString: 'GeometryMultiLineString',
  EdmType.GeometryMultiPolygon: 'GeometryMultiPolygon',
  EdmType.GeometryCollection: 'GeometryCollection',
};

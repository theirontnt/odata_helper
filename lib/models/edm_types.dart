// ignore_for_file: constant_identifier_names

import 'dart:typed_data';
import 'package:decimal/decimal.dart';

enum EdmType {
  Binary,
  Boolean,
  Byte,
  Date,
  DateTimeOffset,
  Decimal,
  Double,
  Duration,
  Guid,
  Int16,
  Int32,
  Int64,
  SByte,
  Single,
  Stream,
  String,
  TimeOfDay,
  Geography,
  GeographyPoint,
  GeographyLineString,
  GeographyPolygon,
  GeographyMultiPoint,
  GeographyMultiLineString,
  GeographyMultiPolygon,
  GeographyCollection,
  Geometry,
  GeometryPoint,
  GeometryLineString,
  GeometryPolygon,
  GeometryMultiPoint,
  GeometryMultiLineString,
  GeometryMultiPolygon,
  GeometryCollection,
}

extension StringToEdmType on String? {
  EdmType get toEdmTypeForEnums {
    if (this == null) {
      return EdmType.Int32;
    }

    String type = this!;

    if (type.startsWith("Edm.")) {
      type = type.substring(4);
    }

    const allowedTypes = [
      EdmType.Byte,
      EdmType.SByte,
      EdmType.Int16,
      EdmType.Int32,
      EdmType.Int64,
    ];

    for (EdmType _entityType in allowedTypes) {
      if (_entityType.name == type) {
        return _entityType;
      }
    }

    throw "Edm Entity Type $type is not supported for [EnumType]";
  }

  EdmType get toEdmType {
    if (this == null) {
      return EdmType.String;
    }

    String type = this!;

    if (type.startsWith("Edm.")) {
      type = type.substring(4);
    }

    for (EdmType _entityType in EdmType.values) {
      if (_entityType.name == type) {
        return _entityType;
      }
    }

    throw "Edm Entity Type $type is not supported";
  }
}

extension EdmToDartType on EdmType {
  Type get resolveDartType {
    switch (this) {
      case EdmType.Binary:
        return Uint8List;
      case EdmType.Boolean:
        return bool;
      case EdmType.Byte:
        return int;
      case EdmType.Date:
      case EdmType.DateTimeOffset:
        return DateTime;
      case EdmType.Decimal:
        return Decimal;
      case EdmType.Double:
        return double;
      case EdmType.Duration:
        return Duration;
      case EdmType.Guid:
        return String;
      case EdmType.Int16:
      case EdmType.Int32:
      case EdmType.Int64:
      case EdmType.SByte:
        return int;
      case EdmType.Single:
        return double;
      case EdmType.Stream:
        return Uint8List;
      case EdmType.String:
        return String;
      case EdmType.TimeOfDay:
      // TODO: Handle this case.
      case EdmType.Geography:
      // TODO: Handle this case.
      case EdmType.GeographyPoint:
      // TODO: Handle this case.
      case EdmType.GeographyLineString:
      // TODO: Handle this case.
      case EdmType.GeographyPolygon:
      // TODO: Handle this case.
      case EdmType.GeographyMultiPoint:
      // TODO: Handle this case.
      case EdmType.GeographyMultiLineString:
      // TODO: Handle this case.
      case EdmType.GeographyMultiPolygon:
      // TODO: Handle this case.
      case EdmType.GeographyCollection:
      // TODO: Handle this case.
      case EdmType.Geometry:
      // TODO: Handle this case.
      case EdmType.GeometryPoint:
      // TODO: Handle this case.
      case EdmType.GeometryLineString:
      // TODO: Handle this case.
      case EdmType.GeometryPolygon:
      // TODO: Handle this case.
      case EdmType.GeometryMultiPoint:
      // TODO: Handle this case.
      case EdmType.GeometryMultiLineString:
      // TODO: Handle this case.
      case EdmType.GeometryMultiPolygon:
      // TODO: Handle this case.
      case EdmType.GeometryCollection:
      // TODO: Handle this case.
      default:
        return dynamic;
    }
  }
}

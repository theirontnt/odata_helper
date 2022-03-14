import 'package:json_annotation/json_annotation.dart';

import '../keywords.dart' as kw;
import '../decoder.dart';
import 'base.dart';
import 'edm_types.dart';

part 'entity_property.g.dart';

@JsonSerializable(anyMap: true)
class EntityProperty extends Base {
  ///For single-valued properties the value of $Type is the qualified name of the property’s type.
  ///
  ///For collection-valued properties the value of $Type is the qualified name of the property’s item type, and the member $Collection MUST be present with the literal value true.
  ///
  ///Absence of the $Type member means the type is Edm.String. This member SHOULD be omitted for string properties to reduce document size.
  late final dynamic type;

  ///For single-valued properties the value of $Type is the qualified name of the property’s type.
  ///
  ///For collection-valued properties the value of $Type is the qualified name of the property’s item type, and the member $Collection MUST be present with the literal value true.
  ///
  ///Absence of the $Type member means the type is Edm.String. This member SHOULD be omitted for string properties to reduce document size.
  late final bool collection;

  /// A Boolean value specifying whether the property can have the value null.
  late final bool nullable;

  ///A positive integer value specifying the maximum length of a binary, stream or string value. For binary or stream values this is the octet length of the binary data, for string values it is the character length (number of code points for Unicode).
  ///
  ///If no maximum length is specified, clients SHOULD expect arbitrary length.
  late final int? maxLength;

  /// For a string property the Unicode facet indicates whether the property might contain and accept string values with Unicode characters (code points) beyond the ASCII character set. The value false indicates that the property will only contain and accept string values with characters limited to the ASCII character set.
  ///
  /// If no value is specified, the Unicode facet defaults to true.
  late final bool unicode;

  /// For a decimal value: the maximum number of significant decimal digits of the property’s value; it MUST be a positive integer.
  ///
  /// For a temporal value (datetime-with-timezone-offset, duration, or time-of-day): the number of decimal places allowed in the seconds portion of the value; it MUST be a non-negative integer between zero and twelve.
  ///
  /// Note: service authors SHOULD be aware that some clients are unable to support a precision greater than 28 for decimal properties and 7 for temporal properties. Client developers MUST be aware of the potential for data loss when round-tripping values of greater precision. Updating via PATCH and exclusively specifying modified properties will reduce the risk for unintended data loss.
  ///
  /// Note: duration properties supporting a granularity less than seconds (e.g. minutes, hours, days) can be annotated with term Measures.DurationGranularity, see [OData-VocMeasures].
  late final int? precision;

  /// A non-negative integer value specifying the maximum number of digits allowed to the right of the decimal point, or one of the symbolic values floating or variable.
  ///
  /// The value floating means that the decimal property represents a decimal floating-point number whose number of significant digits is the value of the Precision facet. OData 4.0 responses MUST NOT specify the value floating.
  ///
  /// The value variable means that the number of digits to the right of the decimal point can vary from zero to the value of the Precision facet.
  ///
  /// An integer value means that the number of digits to the right of the decimal point may vary from zero to the value of the Scale facet, and the number of digits to the left of the decimal point may vary from one to the value of the Precision facet minus the value of the Scale facet. If Precision is equal to Scale, a single zero MUST precede the decimal point.
  ///
  /// The value of Scale MUST be less than or equal to the value of Precision.
  ///
  /// Note: if the underlying data store allows negative scale, services may use a Precision with the absolute value of the negative scale added to the actual number of significant decimal digits, and client-provided values may have to be rounded before being stored.
  late final dynamic scale;

  /// For a geometry or geography property the SRID facet identifies which spatial reference system is applied to values of the property on type instances.
  ///
  /// The value of the SRID facet MUST be a non-negative integer or the special value variable. If no value is specified, the facet defaults to 0 for Geometry types or 4326 for Geography types.
  ///
  /// The valid values of the SRID facet and their meanings are as defined by the European Petroleum Survey Group [EPSG].
  // late final String srid;

  /// A primitive or enumeration property MAY define a default value that is used if the property is not explicitly represented in an annotation or the body of a request or response.
  ///
  /// If no value is specified, the client SHOULD NOT assume a default value.
  late final dynamic defaultValue;

  EntityProperty(String name, JSON json) : super(name, json) {
    type = resolveEdmType(json[kw.type]);
    maxLength = json[kw.maxLength];
    nullable = json[kw.nullable] ?? false;
    unicode = json[kw.unicode] ?? true;
    precision = json[kw.precision];
    scale = json[kw.scale];
    defaultValue = json[kw.defaultValue];
  }

  static dynamic resolveEdmType(String? type) {
    if (type == null) {
      return EdmType.String;
    }

    if (type.startsWith("Edm.")) {
      type = type.substring(4);
    } else {
      // If it's not primitive type, it's probably a reference to a defined type.

      return type;
    }

    for (EdmType _entityType in EdmType.values) {
      if (_entityType.name == type) {
        return _entityType;
      }
    }

    throw "Edm Entity Type $type is not supported";
  }

  static EntityProperty fromJson(JSON json) => _$EntityPropertyFromJson(json);

  JSON toJson() => _$EntityPropertyToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../keywords.dart' as kw;
import '../decoder.dart';
import 'base.dart';
import 'edm_types.dart';
import 'enum_type_value.dart';

part 'enum_type.g.dart';

@JsonSerializable(anyMap: true)
class EnumType extends Base {
  /// An enumeration type MAY specify one of Edm.Byte, Edm.SByte, Edm.Int16, Edm.Int32, or Edm.Int64 as its underlying type.
  ///
  /// If not explicitly specified, Edm.Int32 is used as the underlying type.
  late final EdmType underlyingType;

  @JsonKey(ignore: true)
  late final Type underlyingTypeForDart;

  /// An enumeration type MAY indicate that the enumeration type allows multiple members to be selected simultaneously.
  ///
  /// If not explicitly specified, only one enumeration type member MAY be selected simultaneously.
  ///
  /// Defaults to false
  late final bool isFlags;

  final List<EnumTypeValue> _values = [];
  List<EnumTypeValue> get values => _values.cast();

  EnumType(String name, JSON json) : super(name, json) {
    underlyingType = (json[kw.underlyingType] as String?).toEdmTypeForEnums;
    underlyingTypeForDart = underlyingType.resolveDartType;
    isFlags = json[kw.isFlags] ?? false;

    for (String key in json.keys) {
      if (!key.startsWith(r"$")) {
        _values.add(EnumTypeValue(key, json[key]));
      }
    }
  }

  factory EnumType.fromJson(JSON json) => _$EnumTypeFromJson(json);

  JSON toJson() => _$EnumTypeToJson(this);
}

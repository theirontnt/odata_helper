import '../keywords.dart' as kw;
import '../decoder.dart';
import 'base.dart';
import 'edm_types.dart';

class EnumTypeValue<T> {
  final String name;

  final T value;

  const EnumTypeValue(this.name, this.value);
}

class EnumType extends Base {
  /// An enumeration type MAY specify one of Edm.Byte, Edm.SByte, Edm.Int16, Edm.Int32, or Edm.Int64 as its underlying type.
  ///
  /// If not explicitly specified, Edm.Int32 is used as the underlying type.
  late final EdmType underlyingType;
  late final Type underlyingTypeForDart;

  /// An enumeration type MAY indicate that the enumeration type allows multiple members to be selected simultaneously.
  ///
  /// If not explicitly specified, only one enumeration type member MAY be selected simultaneously.
  ///
  /// Defaults to false
  late final bool isFlags;

  final List<EnumTypeValue> _values = [];
  List<EnumTypeValue> get values => _values.cast();

  EnumType(String _name, JSON _json) : super(_name, _json) {
    underlyingType = (json[kw.underlyingType] as String).toEdmTypeForEnums;
    underlyingTypeForDart = underlyingType.resolveDartType;
    isFlags = json[kw.isFlags] ?? false;

    for (String key in json.keys) {
      if (!key.startsWith(r"$")) {
        _values.add(EnumTypeValue(key, json[key]));
      }
    }
  }
}

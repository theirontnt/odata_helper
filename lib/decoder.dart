import 'package:flat/flat.dart';

import './models/entity.dart';
import './models/enum_type.dart';
import './models/type.dart';
import './models/complex_type.dart';
import 'keywords.dart' as kw;

typedef JSON = Map<String, dynamic>;

class ODataDecoder {
  final JSON json;

  late final String version;

  late final String entityContainer;

  late final JSON decoded;
  final Map<String, bool> decodedFlag = {};

  dynamic resolve(String _name, JSON _json) {
    switch (_json[kw.kind]) {
      case kw.enumKind:
        return EnumType(_name, _json);
      case kw.typeDefKind:
        return TypeDefinition(_name, _json);
      case kw.entityKind:
        return Entity(_name, _json);
      case kw.complexTypeKind:
        return ComplexType(_name, _json);
      default:
        return null;
    }
  }

  ODataDecoder(this.json) {
    json.remove("System");

    json.removeWhere((key, value) => key.startsWith("System.") || key.startsWith("DevExpress."));

    // At this point, JSON has all the info we need.

    version = json[r"$Version"];

    if (!version.startsWith("4.")) {
      throw "OData Helper only support OData v4.xx";
    }

    entityContainer = json[r"$EntityContainer"];

    json.remove(r"$Version");
    json.remove(r"$EntityContainer");
    // Figure this shit
    json.remove(r"Default");

    decoded = flatten(json, safe: true, maxDepth: 2);

    decoded.forEach((key, value) {
      if (decodedFlag[key] == true) return;

      try {
        decoded[key] = resolve(key, value);
        decodedFlag[key] = true;
      } catch (e) {
        print("Failed to resolve $key:$value; thrown error is: \"$e\"");
      }
    });

    // We'll use the flag for generation process
    decodedFlag.clear();
  }

  void generate() {}
}

import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';

import 'decoder.dart';
import 'keywords.dart' as kw;

class DataClassBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    final JSON json = jsonDecode(await buildStep.readAsString(inputId));

    json.remove("System");

    for (String key in json.keys) {
      if (key.startsWith("System.")) {
        json.remove(key);
        continue;
      }
      if (key.startsWith("DevExpress.")) {
        json.remove(key);
        continue;
      }
    }

    // At this point, JSON has all the info we need.

    final String version = json[r"$Version"];

    if (!version.startsWith("4.")) {
      throw "OData Helper only support OData v4.xx";
    }

    final String entityContainer = json[r"$EntityContainer"];

    final List<JSON> models = [];

    final List<JSON> types = [];
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        ".json": [kw.entityExt, kw.typeExt],
      };
}

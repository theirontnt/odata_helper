library code_gen;

import 'package:odata_helper/models/entity_property.dart';

String generateClass(String name, List<EntityProperty> properties) {
  final List<String> value = [];

  value.add("class $name {");

  for (EntityProperty property in properties) {
    value.add("/t${property.type.toString()}${property.type == 'dynamic' ? '' : '?'} ${property.name};");
  }

  value.add("}");

  return value.join("/n");
}

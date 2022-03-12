import '../decoder.dart';

class Base {
  final String name;
  final JSON json;

  final JSON annotations = {};

  Base(this.name, this.json) {
    for (String key in json.keys) {
      if (key.startsWith("@")) {
        annotations[key] = json[key];
        json.remove(key);
      }
    }
  }
}

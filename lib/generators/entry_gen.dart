import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class EntryGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader libraryReader, BuildStep buildStep) async {
    final List<String> output = [];

    output.add("library ${libraryReader.element.name};");

    return output.join("\n");
  }
}

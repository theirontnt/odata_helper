import 'dart:convert';
import 'dart:io';

import 'package:odata_helper/decoder.dart';

void main() {
  print(Directory.current.path);

  File file = File("${Directory.current.path}\\test\\test.json");

  String s = file.readAsStringSync();

  ODataDecoder decoder = ODataDecoder(jsonDecode(s));

  File result = File("${Directory.current.path}\\test\\result.txt");

  result.createSync();
  result.writeAsStringSync(jsonEncode(decoder.decoded));
}

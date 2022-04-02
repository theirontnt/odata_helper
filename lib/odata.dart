import 'package:built_collection/built_collection.dart';

class OData {
  final String baseUrl;

  const OData(this.baseUrl);

  Future<T?> get<T>(String path) async {
    throw UnimplementedError();
  }

  Future<BuiltList<T?>> getList<T>(String path) async {
    throw UnimplementedError();
  }
}

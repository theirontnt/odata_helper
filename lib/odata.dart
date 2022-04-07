import 'package:built_collection/built_collection.dart';
import 'package:odata_helper/odata/query_options.dart';

import 'odata/query.dart';

class OData {
  late final String baseUrl;

  String? _cookie;
  set cookie(String cookies) => _cookie = cookies;
  String? _bearer;
  set bearer(String token) => _bearer = token;

  OData(String _baseUrl) {
    if (_baseUrl.contains(r"://")) {
      baseUrl = _baseUrl.split("://").last;
    } else {
      baseUrl = _baseUrl;
    }
  }

  /// [tryUseAuth] will attach Authorization information to the Headers if possible
  Query<T> single<T>(String path, {QueryOptions<T> options = const QueryOptions(), bool tryUseAuth = true}) {
    return Query<T>(
      baseUrl: baseUrl,
      options: options,
      path: path,
      cookie: tryUseAuth ? _cookie : null,
      bearer: tryUseAuth ? _bearer : null,
    );
  }

  /// [tryUseAuth] will attach Authorization information to the Headers if possible
  CollectionQuery<T> collection<T>(String path, {QueryOptions options = const QueryOptions(), bool tryUseAuth = true}) {
    return CollectionQuery<T>(
      baseUrl: baseUrl,
      path: path,
      cookie: tryUseAuth ? _cookie : null,
      bearer: tryUseAuth ? _bearer : null,
    );
  }

  void setCookie(String cookie) {
    _cookie = cookie;
  }

  void setBearer(String token) {
    _bearer = token;
  }

  Future<T?> get<T>(String path) async {
    throw UnimplementedError();
  }

  Future<BuiltList<T?>> getList<T>(String path) async {
    throw UnimplementedError();
  }
}

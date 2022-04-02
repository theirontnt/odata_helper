import 'package:http/http.dart' as http;

import 'package:odata_helper/odata/result.dart';

class Query<T> {
  final String baseUrl;

  /// Full path will be: `$baseUrl/$path`
  final String path;

  dynamic _filter;
  dynamic _expand;
  dynamic _select;

  Query({required this.baseUrl, required this.path});

  Future<ODataResult<T>?> fetch() async {
    final http.Request req = http.Request("GET", Uri.https(baseUrl, path));
  }
}

class CollectionQuery<T> extends Query {
  dynamic _top;
  dynamic _skip;
  dynamic _count;
  dynamic _orderby;
  dynamic _search;

  CollectionQuery({required String baseUrl, required String path}) : super(baseUrl: baseUrl, path: path);
}

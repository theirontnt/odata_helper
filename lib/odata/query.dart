import 'package:http/http.dart' as http;
import 'package:odata_helper/odata/query_fields.dart';

import 'package:odata_helper/odata/result.dart';

abstract class QueryBase {
  final String baseUrl;

  /// Full path will be: `$baseUrl/$path`
  final String path;

  const QueryBase(this.baseUrl, this.path);

  Future<ODataResponse?> fetch();
}

class Query<T> extends QueryBase {
  final String? cookie;
  final String? bearer;

  List<String> _filter = [];
  List<ExpandQueryField> _expand = [];
  List<String> _select = [];
  bool _selectAll = false;

  Query({required String baseUrl, required String path, this.cookie, this.bearer}) : super(baseUrl, path);

  JSON get headers {
    final JSON value = {};

    if (cookie != null) {
      value["Cookie"] = cookie;
    }
    if (bearer != null) {
      value["Authorization"] = "Bearer $bearer";
    }

    value["Accept-Charset"] = "UTF-8";

    return value;
  }

  JSON queries() {
    final JSON value = {};

    value["\$filter"] = _filter.join(", ");
    value["\$expand"] = _expand.join(", ");

    if (_selectAll) {
      value["\$select"] = "*";
    } else {
      value["\$select"] = _select.join(", ");
    }

    return value;
  }

  Future<ODataResponse<T>?> fetch() async {
    final http.Request req = http.Request("GET", Uri.https(baseUrl, path, queries()));

    headers.forEach((key, value) {
      req.headers[key] = value;
    });

    http.StreamedResponse streamedResponse = await req.send();
  }

  Query<T> select(Iterable<String> fields) {
    if (_selectAll) {
      throw Exception("[OData Helper] Defining fields to select when 'selectAll' is enabled is useless");
    }

    _select = {..._select, ...fields}.toList();

    return this;
  }

  Query<T> selectAll() {
    _selectAll = true;

    return this;
  }

  Query<T> filter(String expression) {
    if (!_filter.contains(expression)) {
      _filter.add(expression);
    }

    return this;
  }

  Query<T> expand(ExpandQueryField expandQueryField) {
    _expand = {..._expand, expandQueryField}.toList();

    return this;
  }
}

class CollectionQuery<T> extends Query {
  int? _top;
  int? _skip;
  bool _count = false;
  List<OrderyByField> _orderby = [];
  String? _search;

  CollectionQuery({required String baseUrl, required String path, String? cookie, String? bearer}) : super(baseUrl: baseUrl, path: path, bearer: bearer, cookie: cookie);

  CollectionQuery top(int i) {
    if (i.isNegative) {
      throw Exception("\$top cannot accept negative value");
    }

    _top = i;

    return this;
  }

  CollectionQuery skip(int i) {
    if (i.isNegative) {
      throw Exception("\$skip cannot accept negative value");
    }

    _skip = i;

    return this;
  }

  CollectionQuery skipAndTop({required int skip, required int top}) {
    if (skip.isNegative || top.isNegative) {
      throw Exception("Either \$skip and \$top cannot accept negative value");
    }

    _skip = skip;
    _top = top;

    return this;
  }

  CollectionQuery count() {
    _count = true;

    return this;
  }

  CollectionQuery orderby(OrderyByField orderyByField) {
    _orderby = {..._orderby, orderyByField}.toList();

    return this;
  }

  CollectionQuery search(String searchQuery) {
    _search = searchQuery;

    return this;
  }
}

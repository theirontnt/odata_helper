import 'package:http/http.dart';

typedef JSON = Map<String, dynamic>;

class ODataResult<T> {
  /// @odata.context
  final String? context;

  /// Response data
  final T? data;

  /// Raw response
  final Response? response;

  /// Response status code
  final int? statusCode;

  /// Full path of the sent request
  final String path;

  ODataResult({this.context, this.data, this.response, this.statusCode, required this.path});
}

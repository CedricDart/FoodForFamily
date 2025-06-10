import 'package:food_for_family/common/models/base/serializable.dart';

enum RequestMethod { get, post, delete }

class GenericRequest {
  RequestMethod method;
  Uri uri;
  Map<String, String> headers;
  Map<String, dynamic>? query;
  Serializable? body;
  String traceName;

  GenericRequest({
    required this.method,
    required this.uri,
    required this.headers,
    this.query,
    this.body,
    required this.traceName,
  });
}

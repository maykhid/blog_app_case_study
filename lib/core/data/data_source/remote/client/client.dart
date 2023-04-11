import 'package:http/http.dart' as http;

/// interface client just incase we decide to swap an impl lateer
abstract class IClient {
  Future<http.Response> get(Uri url, {Map<String, String>? headers});
}

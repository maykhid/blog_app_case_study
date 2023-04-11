import 'package:blog_app_case_study/core/data/data_source/remote/client/client.dart';
import 'package:http/http.dart';

class HttpClient implements IClient {
  HttpClient({required Client httpClient}) : _httpClient = httpClient;

  final Client _httpClient;

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) =>
      _httpClient.get(url, headers: headers ?? {});
}

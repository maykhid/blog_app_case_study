import 'dart:convert';

import 'package:blog_app_case_study/app/features/authors/data/data_source/remote/authors_api_client.dart';
import 'package:blog_app_case_study/app/shared/models/authors_response.dart';
import 'package:http/http.dart';

import '../../../../../../core/data/data_source/remote/api_configs.dart';
import '../../../../../../core/model/error/exception.dart';

class HttpAuthorsApiClient implements AuthorsApiClient {
  final Client _client;

  final Map<String, String> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  final String _authorsPath = "/users";


  HttpAuthorsApiClient({required Client client}) : _client = client;

  @override
  Future<AuthorsResponse> getAuthors() async {
     final url = Uri.https(ApiConfigs.jsonPlaceholderUrl, _authorsPath);
    try {
      final response = await _client.get(url, headers: _headers);
      return AuthorsResponse.fromJson(jsonDecode(response.body));
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

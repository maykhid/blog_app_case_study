import 'dart:convert';

import '../../../../../../core/data/data_source/remote/api_configs.dart';
import '../../../../../../core/data/data_source/remote/client/client.dart';
import '../../../../../../core/data/data_source/remote/client/response_handler.dart';
import '../../../../../shared/data/models/authors_response.dart';
import 'authors_remote_data_source.dart';

class HttpAuthorsRemoteDataSource implements AuthorsRemoteDataSource {
  final IClient _client;

  final Map<String, String> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  final String _authorsPath = "/users";

  HttpAuthorsRemoteDataSource({required IClient client}) : _client = client;

  @override
  Future<AuthorsResponse> getAuthors() async {
    final url = Uri.https(ApiConfigs.jsonPlaceholderUrl, _authorsPath);
    try {
      final response = await _client.get(url, headers: _headers);
      final responseOrError = HttpResponseHandler().handleResponse(response);
      return AuthorsResponse.fromJson(jsonDecode(responseOrError.body));
    } catch (e) {
      rethrow;
    }
  }
}

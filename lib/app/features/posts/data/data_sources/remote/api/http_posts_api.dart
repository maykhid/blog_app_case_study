import 'dart:convert';
import 'dart:io';

import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/posts_api.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/api_configs.dart';
import 'package:blog_app_case_study/core/data/model/error/exception.dart'
    // ignore: library_prefixes
    as customException;
import 'package:http/http.dart' as http;

class HttpPostsApi extends PostsApi {
  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  final String _postsPath = '/posts';
  final String _usersPath = '/users';

  @override
  Future<AuthorsResponse> getAuthors() async {
    try {
      final response = await http.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, _usersPath),
        headers: _headers,
      );
      return AuthorsResponse.fromJson(response.handleResponse as List);
    } on SocketException catch (_) {
      throw Exception('Check your internet connection!');
    }
  }

  @override
  Future<PostsResponse> getPosts() async {
    try {
      final response = await http.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, _postsPath),
        headers: _headers,
      );
      return PostsResponse.fromJson(response.handleResponse as List);
    } on SocketException catch (_) {
      throw Exception('Check your internet connection!');
    }
  }
}

extension HttpResponseHandler on http.Response {
  dynamic get handleResponse {
    if (statusCode == 200) {
      return jsonDecode(body);
    } else if (statusCode >= 400 && statusCode <= 404) {
      throw customException.ClientException(
        'Client Exception: $reasonPhrase',
        statusCode,
      );
    }
    throw customException.ServerException(
      'Server Exception: $reasonPhrase',
      statusCode,
    );
  }
}

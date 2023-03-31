import 'dart:convert';

import 'package:blog_app_case_study/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/api_configs.dart';
import 'package:blog_app_case_study/core/model/error/exception.dart';
import 'package:http/http.dart';

import '../../../../../shared/models/posts_response.dart';

class HttpPostsApiClient implements PostsApiClient {
  // Client from the http package
  final Client _client;

  final Map<String, String> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  final String _postsPath = "/posts";

  HttpPostsApiClient({required Client client}) : _client = client;

  @override
  Future<PostsResponse> getPosts() async {
    final url = Uri.https(ApiConfigs.jsonPlaceholderUrl, _postsPath);
    try {
      final response = await _client.get(url, headers: _headers);
      return PostsResponse.fromJson(jsonDecode(response.body));
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

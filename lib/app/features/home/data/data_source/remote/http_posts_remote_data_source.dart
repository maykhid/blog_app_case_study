import 'dart:convert';

import 'package:blog_app_case_study/app/features/home/data/data_source/remote/posts_remote_data_source.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/api_configs.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/client/response_handler.dart';

import '../../../../../../core/data/data_source/remote/client/client.dart';
import '../../../../../shared/models/posts_response.dart';

class HttpPostsRemoteDataSource implements PostsRemoteDataSource {
  // Client from the http package
  final IClient _client;

  final Map<String, String> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  final String _postsPath = "/posts";

  HttpPostsRemoteDataSource({required IClient client}) : _client = client;

  @override
  Future<PostsResponse> getPosts() async {
    final url = Uri.https(ApiConfigs.jsonPlaceholderUrl, _postsPath);

    try {
      final response = await _client.get(url, headers: _headers);
      final responseOrError = HttpResponseHandler().handleResponse(response);
      return PostsResponse.fromJson(jsonDecode(responseOrError.body));
    } catch (e) {
      rethrow;
    }
  }
}


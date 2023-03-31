import 'package:http/http.dart';

import '../../../../../shared/models/posts_response.dart';

abstract class PostsApiClient {
  PostsApiClient({required Client client}) : _client = client;

  final Client _client;

  Future<PostsResponse> getPosts();
}

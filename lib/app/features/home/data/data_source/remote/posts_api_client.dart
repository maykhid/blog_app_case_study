import '../../../../../shared/models/posts_response.dart';

abstract class PostsApiClient {
  Future<PostsResponse> getPosts();
}

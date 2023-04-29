import '../../../../../shared/data/models/posts_response.dart';

abstract class PostsRemoteDataSource {
  Future<PostsResponse> getPosts();
}

import '../../../../../shared/models/posts_response.dart';

abstract class PostsDao {
  void cachePosts({required PostsResponse posts});
  bool get isPostsCacheAvailable;
  PostsResponse? getCachedPosts();
}

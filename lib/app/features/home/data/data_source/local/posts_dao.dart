import '../../../../../shared/models/posts.dart';

abstract class PostsDao {
  void cachePosts({required Posts posts});
  bool get isPostsCacheAvailable;
  Posts? getCachedPosts();
}

import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';

abstract class BlogPostsLocalDataSource {
  void cacheAuthors({required AuthorsResponse authors});
  bool get isAuthorsCacheAvailable;
  AuthorsResponse? getCachedAuthors();

  void cachePosts({required PostsResponse posts});
  bool get isPostsCacheAvailable;
  PostsResponse? getCachedPosts();
}

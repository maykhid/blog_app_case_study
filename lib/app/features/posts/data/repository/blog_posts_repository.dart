import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/blog_posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/blog_remote_data_source.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/data/resource.dart';

class BlogPostsRepository {
  const BlogPostsRepository(
      {required BlogPostsRemoteDataSource blogPostsRemoteDataSource,
      required BlogPostsLocalDataSource blogPostsLocalDataSource})
      : _blogPostsRemoteDataSource = blogPostsRemoteDataSource,
        _blogPostsLocalDataSource = blogPostsLocalDataSource;

  final BlogPostsRemoteDataSource _blogPostsRemoteDataSource;
  final BlogPostsLocalDataSource _blogPostsLocalDataSource;

  Future<Resource<PostsResponse>> getPosts() async {
    try {
      final response = await _blogPostsRemoteDataSource.getPosts();
      _blogPostsLocalDataSource.cachePosts(posts: response);
       
      return Resource.success(_blogPostsLocalDataSource.getCachedPosts());
    } catch (e) {
      if (_blogPostsLocalDataSource.isPostsCacheAvailable) {
        return Resource.success(_blogPostsLocalDataSource.getCachedPosts());
      }
      return Resource.failure(errorMessage: e.toString());
    }
  }

  Future<Resource<AuthorsResponse>> getAuthors() async {
    try {
      final response = await _blogPostsRemoteDataSource.getAuthors();
      _blogPostsLocalDataSource.cacheAuthors(authors: response);
      
      return Resource.success(_blogPostsLocalDataSource.getCachedAuthors());
    } catch (e) {
      if (_blogPostsLocalDataSource.isAuthorsCacheAvailable) {
        return Resource.success(_blogPostsLocalDataSource.getCachedAuthors());
      }
      return Resource.failure(errorMessage: e.toString());
    }
  }
}

import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/posts_remote_data_source.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/data/result.dart';

class PostsRepository {
  const PostsRepository({
    required PostsRemoteDataSource postsRemoteDataSource,
    required PostsLocalDataSource postsLocalDataSource,
  })  : _postsRemoteDataSource = postsRemoteDataSource,
        _postsLocalDataSource = postsLocalDataSource;

  final PostsRemoteDataSource _postsRemoteDataSource;
  final PostsLocalDataSource _postsLocalDataSource;

  Future<Result<PostsResponse>> getPosts() async {
    try {
      final response = await _postsRemoteDataSource.getPosts();
      _postsLocalDataSource.updatePosts(posts: response);

      return Result.success(_postsLocalDataSource.getPosts());
    } catch (e) {
      if (_postsLocalDataSource.isPostsAvailable) {
        return Result.success(_postsLocalDataSource.getPosts());
      }
      return Result.failure(errorMessage: e.toString());
    }
  }

  Future<Result<AuthorsResponse>> getAuthors() async {
    try {
      final response = await _postsRemoteDataSource.getAuthors();
      _postsLocalDataSource.updateAuthors(authors: response);

      return Result.success(_postsLocalDataSource.getAuthors());
    } catch (e) {
      if (_postsLocalDataSource.isAuthorsAvailable) {
        return Result.success(_postsLocalDataSource.getAuthors());
      }
      return Result.failure(errorMessage: e.toString());
    }
  }
}

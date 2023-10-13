import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/posts_local_data_source.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/model/error/exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBlogPostsLocalDataSource extends PostsLocalDataSource {
  HiveBlogPostsLocalDataSource({
    required Box<PostsResponse> postsBox,
    required Box<AuthorsResponse> authorsBox,
  })  : _postsBox = postsBox,
        _authorsBox = authorsBox;

  final Box<PostsResponse> _postsBox;
  final Box<AuthorsResponse> _authorsBox;

  static const String _postKey = '__posts__key__';
  static const String _authorsKey = '__authors__key__';

  @override
  void cacheAuthors({required AuthorsResponse authors}) =>
      _authorsBox.put(_authorsKey, authors).onError(
            (error, stackTrace) =>
                throw LocalStorageException(error.toString()),
          );

  @override
  void cachePosts({required PostsResponse posts}) =>
      _postsBox.put(_postKey, posts).onError(
            (error, stackTrace) =>
                throw LocalStorageException(error.toString()),
          );

  @override
  AuthorsResponse? getCachedAuthors() => _authorsBox.get(_authorsKey);

  @override
  PostsResponse? getCachedPosts() => _postsBox.get(_postKey);

  @override
  bool get isAuthorsCacheAvailable => _authorsBox.isNotEmpty;

  @override
  bool get isPostsCacheAvailable => _postsBox.isNotEmpty;
}

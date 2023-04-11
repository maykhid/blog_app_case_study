import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';
import '../../../home/data/data_source/local/posts_dao.dart';
import '../../../home/data/data_source/remote/posts_remote_data_source.dart';

class SearchRepository {
  final PostsRemoteDataSource _postsRemoteDataSource;
  final PostsDao _postsDao;

  SearchRepository(
      {required PostsRemoteDataSource postsRemoteDataSource, required PostsDao postsDao})
      : _postsRemoteDataSource = postsRemoteDataSource,
        _postsDao = postsDao;

  Future<Either<Failure, PostsResponse>> search(String searchTerm) async {
    try {
      List<Post> foundPosts = [];

      final postsResponse = await _postsRemoteDataSource.getPosts();

      // store posts locally
      _postsDao.cachePosts(posts: postsResponse);

      // search title
      foundPosts = postsResponse.posts
          .where((post) =>
              post.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return Right(PostsResponse(posts: foundPosts));
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, PostsResponse>> searchOffline(
      String searchTerm) async {
    try {
      List<Post> foundPosts = List<Post>.empty();

      final cachedPosts = _postsDao.getCachedPosts()!;

      foundPosts = cachedPosts.posts
          .where((post) =>
              post.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return Right(PostsResponse(posts: foundPosts));
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

   Future<Either<Failure, PostsResponse>>
      seacrchLiveOrOfflinePosts(String searchTerm) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    bool isPostsCacheAvailable =
        _postsDao.isPostsCacheAvailable;

    if (!hasConnection && isPostsCacheAvailable) {
      return searchOffline(searchTerm);
    }
    return search(searchTerm);
  }
}

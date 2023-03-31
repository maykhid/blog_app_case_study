import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';
import '../data_source/local/posts_dao.dart';
import '../data_source/remote/posts_api_client.dart';

class PostRepository {
  final PostsApiClient _postsApiClient;
  final PostsDao _postsDao;

  PostRepository(
      {required PostsApiClient postsApiClient, required PostsDao postDao})
      : _postsApiClient = postsApiClient,
        _postsDao = postDao;

  Future<Either<Failure, PostsResponse>> getPosts() async {
    try {
      final postsResponse = await _postsApiClient.getPosts();

      // store posts locally
      _postsDao.cachePosts(posts: postsResponse);

      return Right(postsResponse);
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, PostsResponse>> getCachedPosts() async {
    try {
      final cachedPosts = _postsDao.getCachedPosts()!;
      return Right(cachedPosts);
    } on Exception catch (_) {
      return Left(LocalStorageFailure(message: _.toString()));
    }
  }

  Future<Either<Failure, PostsResponse>> getLiveOrCachedPosts() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    bool isPostsCacheAvailable = _postsDao.isPostsCacheAvailable;

    if (!hasConnection && isPostsCacheAvailable) {
      return getCachedPosts();
    }
    return getPosts();
  }
}

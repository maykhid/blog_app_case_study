import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';
import '../../../home/data/data_source/local/posts_dao.dart';
import '../../../home/data/data_source/remote/posts_api_client.dart';

class SearchRepository {
  final PostsApiClient _postsApiClient;
  final PostsDao _postDao;

  SearchRepository(
      {required PostsApiClient postsApiClient, required PostsDao postDao})
      : _postsApiClient = postsApiClient,
        _postDao = postDao;

  Future<Either<Failure, PostsResponse>> search(String searchTerm) async {
    try {
      List<Post> foundPosts = [];

      final postsResponse = await _postsApiClient.getPosts();

      // store posts locally
      _postDao.cachePosts(posts: postsResponse);

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

      final cachedPosts = _postDao.getCachedPosts()!;

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
        _postDao.isPostsCacheAvailable;

    if (!hasConnection && isPostsCacheAvailable) {
      return searchOffline(searchTerm);
    }
    return search(searchTerm);
  }
}

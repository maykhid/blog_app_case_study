import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';
import '../data_source/local/posts_dao.dart';
import '../data_source/remote/posts_remote_data_source.dart';

class PostRepository {
  final PostsRemoteDataSource _postsRemoteDataSource;
  final PostsDao _postsDao;

  PostRepository(
      {required PostsRemoteDataSource postsRemoteDataSource,
      required PostsDao postDao})
      : _postsRemoteDataSource = postsRemoteDataSource,
        _postsDao = postDao;

  Future<Either<Failure, PostsResponse>> getPosts() async {
    try {
      final postsResponse = await _postsRemoteDataSource.getPosts();

      // store posts locally
      _postsDao.cachePosts(posts: postsResponse);

      return Right(postsResponse);
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message, code: e.code.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code.toString()));
    } on LocalStorageException catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString(), code: '0'));
    }
  }

  Future<Either<Failure, PostsResponse>> getCachedPosts() async {
    try {
      final cachedPosts = _postsDao.getCachedPosts()!;
      return Right(cachedPosts);
    } on LocalStorageException catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, PostsResponse>> call() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    bool isPostsCacheAvailable = _postsDao.isPostsCacheAvailable;

    if (!hasConnection && isPostsCacheAvailable) {
      return getCachedPosts();
    }
    return getPosts();
  }
}

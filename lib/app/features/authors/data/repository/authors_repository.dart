import 'package:blog_app_case_study/app/features/authors/data/data_source/remote/authors_api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';
import '../../../../shared/models/authors_response.dart';
import '../data_source/local/authors_dao.dart';

class AuthorsRepository {
  final AuthorsApiClient _authorsApiClient;
  final AuthorsDao _authorsDao;

  AuthorsRepository(
      {required AuthorsApiClient authorsApiClient,
      required AuthorsDao authorsDao})
      : _authorsApiClient = authorsApiClient,
        _authorsDao = authorsDao;

  Future<Either<Failure, AuthorsResponse>> getAuthors() async {
    try {
      final authorsResponse = await _authorsApiClient.getAuthors();

      // store authors locally
      _authorsDao.cacheAuthors(authors: authorsResponse);

      return Right(authorsResponse);
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

  Future<Either<Failure, AuthorsResponse>> getCachedAuthors() async {
    try {
      final cachedAuhtors = _authorsDao.getCachedAuthors()!;
      return Right(cachedAuhtors);
    } on Exception catch (_) {
      return Left(LocalStorageFailure(message: _.toString()));
    }
  }

  Future<Either<Failure, AuthorsResponse>> getLiveOrCachedAuthors() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    bool isAuthorsCacheAvailable = _authorsDao.isAuthorsCacheAvailable;

    if (!hasConnection && isAuthorsCacheAvailable) {
      return getCachedAuthors();
    }
    return getAuthors();
  }
}

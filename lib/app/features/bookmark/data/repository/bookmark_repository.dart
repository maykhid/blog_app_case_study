import 'package:blog_app_case_study/core/model/error/exception.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/model/error/failure.dart';
import '../../../../shared/data/models/posts_response.dart';
import '../../../../shared/data/repository/repository.dart';
import '../data_source/local/bookmark_dao.dart';

class BookmarkRepository extends IRepository {
  final BookmarkDao _bookmarkDao;

  BookmarkRepository({required BookmarkDao bookmarkDao})
      : _bookmarkDao = bookmarkDao;

  @override
  Future<Either<Failure, PostsResponse>> call([String? search]) async {
    try {
      final bookmarkedPosts = _bookmarkDao.getAllBookmarkedPosts();
      return Right(bookmarkedPosts!);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  void bookmarkPost(Post post) async {
    try {
      _bookmarkDao.bookmarkPost(post: post);
    } on LocalStorageException catch (e) {
      throw LocalStorageFailure(message: e.toString());
    } on Exception catch (e) {
      throw UnexpectedFailure(message: e.toString());
    }
  }

  void clearBookmarkedPost(int index) async {
    try {
      _bookmarkDao.clearBookmarkedPost(index: index);
    } on LocalStorageException catch (e) {
      throw LocalStorageFailure(message: e.toString());
    } on Exception catch (e) {
      throw UnexpectedFailure(message: e.toString());
    }
  }
}

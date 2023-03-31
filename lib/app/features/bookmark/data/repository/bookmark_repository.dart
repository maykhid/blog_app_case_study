import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/model/error/failure.dart';
import '../data_source/local/bookmark_dao.dart';

class BookmarkRepository {
  final BookmarkDao _bookmarkDao;

  BookmarkRepository({required BookmarkDao bookmarkDao})
      : _bookmarkDao = bookmarkDao;

  Future<Either<Failure, PostsResponse>> getAllBookmarkedPosts() async {
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
    } on Exception catch (e) {
      throw LocalStorageFailure(message: e.toString());
    }
  }

  void clearBookmarkedPost(int index) async {
    try {
      _bookmarkDao.clearBookmarkedPost(index: index);
    } on Exception catch (e) {
      throw LocalStorageFailure(message: e.toString());
    }
  }
}

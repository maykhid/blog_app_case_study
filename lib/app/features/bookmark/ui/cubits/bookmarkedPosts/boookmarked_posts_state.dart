import 'package:blog_app_case_study/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';


class BookmarkPostsState extends Equatable {
  const BookmarkPostsState._({
    this.message,
    this.bookmarkedPostsUsers,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final PostsWithAuthors? bookmarkedPostsUsers;

  const BookmarkPostsState.unknown() : this._();

  const BookmarkPostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const BookmarkPostsState.done(
      {required PostsWithAuthors bookmarkedPostsUsers})
      : this._(
            status: DataResponseStatus.success,
            bookmarkedPostsUsers: bookmarkedPostsUsers);

  const BookmarkPostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, bookmarkedPostsUsers];
}

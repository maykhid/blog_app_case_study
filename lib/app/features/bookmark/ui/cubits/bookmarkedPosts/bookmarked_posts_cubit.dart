import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/get_posts_with_authors_usecase.dart';
import '../../../../authors/data/repository/authors_repository.dart';
import '../../../data/repository/bookmark_repository.dart';
import 'boookmarked_posts_state.dart';

class BookmarkPostsCubit extends Cubit<BookmarkPostsState> {
  BookmarkPostsCubit(
      {required GetPostsWithAuthorsUseCase<AuthorsRepository,
              BookmarkRepository>
          getPostsWithAuthorsUseCase})
      : _getPostsWithAuthorsUseCase = getPostsWithAuthorsUseCase,
        super(const BookmarkPostsState.unknown());

  final GetPostsWithAuthorsUseCase<AuthorsRepository, BookmarkRepository>
      _getPostsWithAuthorsUseCase;

  Future<void> getBookmarkedPosts() async {
    emit(const BookmarkPostsState.processing());
    final response = await _getPostsWithAuthorsUseCase();
    emit(response.fold(
        (error) => BookmarkPostsState.failed(message: error.message),
        (res) => BookmarkPostsState.done(bookmarkedPostsUsers: res)));
  }

  // void bookmarkPost(Post post) => _bookmarkRepository.bookmarkPost(post);

  // void clearBookmarkedPost(int index) =>
  //     _bookmarkRepository.clearBookmarkedPost(index);
}

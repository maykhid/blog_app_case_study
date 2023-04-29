import 'package:blog_app_case_study/core/model/params/params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/data/models/posts_response.dart';
import '../../../../../shared/domain/get_posts_with_authors_usecase.dart';
import '../../../../authors/data/repository/authors_repository.dart';
import '../../../data/repository/bookmark_repository.dart';
import 'boookmarked_posts_state.dart';

class BookmarkPostsCubit extends Cubit<BookmarkPostsState> {
  BookmarkPostsCubit({
    required GetPostsWithAuthorsUseCase<AuthorsRepository, BookmarkRepository>
        getPostsWithAuthorsUseCase,
    required BookmarkRepository bookmarkRepository,
  })  : _getPostsWithAuthorsUseCase = getPostsWithAuthorsUseCase,
        _bookmarkRepository = bookmarkRepository,
        super(
          const BookmarkPostsState.unknown(),
        );

  final GetPostsWithAuthorsUseCase _getPostsWithAuthorsUseCase;
  final BookmarkRepository _bookmarkRepository;

  Future<void> getBookmarkedPosts() async {
    emit(const BookmarkPostsState.processing());
    final response = await _getPostsWithAuthorsUseCase(NoParams());
    emit(response.fold(
        (error) => BookmarkPostsState.failed(message: error.message),
        (res) => BookmarkPostsState.done(bookmarkedPostsUsers: res)));
  }

  void bookmarkPost(Post post) => _bookmarkRepository.bookmarkPost(post);

  void clearBookmarkedPost(int index) =>
      _bookmarkRepository.clearBookmarkedPost(index);
}

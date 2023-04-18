import 'package:blog_app_case_study/app/features/search/data/repository/search_repository.dart';
import 'package:blog_app_case_study/app/shared/domain/get_posts_with_authors_usecase.dart';
import 'package:blog_app_case_study/core/model/params/params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authors/data/repository/authors_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required GetPostsWithAuthorsUseCase<AuthorsRepository, SearchRepository> getPostsWithAuthorsUseCase})
      : _getPostsWithAuthorsUseCase = getPostsWithAuthorsUseCase,
        super(const SearchState.unknown());

  final GetPostsWithAuthorsUseCase<AuthorsRepository, SearchRepository> _getPostsWithAuthorsUseCase;

  Future<void> search(String searchTerm) async {
    emit(const SearchState.processing());
    final response = await _getPostsWithAuthorsUseCase(SearchParams(searchTerm: searchTerm));
    emit(response.fold((error) => SearchState.failed(message: error.message),
        (res) => SearchState.done(response: res)));
  }
}
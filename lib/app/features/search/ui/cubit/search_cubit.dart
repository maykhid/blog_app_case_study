import 'package:blog_app_case_study/app/features/search/domain/search_usecase.dart';
import 'package:blog_app_case_study/core/utils/enums.dart';
import 'package:blog_app_case_study/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required SearchPostsWithAuthorsUseCase searchPostsWithAuthorsUseCase,
  })  : _searchPostsWithAuthorsUseCase = searchPostsWithAuthorsUseCase,
        super(const SearchState.unknown());

  final SearchPostsWithAuthorsUseCase _searchPostsWithAuthorsUseCase;

  Future<void> search(String searchTerm) async {
    emit(const SearchState.processing());

    final response = await _searchPostsWithAuthorsUseCase(searchTerm);

    if (response.isFailure) {
      emit(SearchState.failed(message: response.errorMessage));
    } else {
      emit(SearchState.done(response: response.data!));
    }
  }
}

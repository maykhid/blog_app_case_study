import 'package:blog_app_case_study/app/features/authors/data/repository/authors_repository.dart';
import 'package:blog_app_case_study/app/features/home/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/app/shared/domain/get_posts_with_authors_usecase.dart';
import 'package:blog_app_case_study/core/model/params/params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(
      {required GetPostsWithAuthorsUseCase<AuthorsRepository, PostRepository>
          getPostsWithAuthorsUseCase})
      : _getPostsWithAuthorsUseCase = getPostsWithAuthorsUseCase,
        super(const PostsState.unknown());

  final GetPostsWithAuthorsUseCase<AuthorsRepository, PostRepository>
      _getPostsWithAuthorsUseCase;

  Future<void> getPostsAuthors() async {
    emit(const PostsState.processing());
    final response = await _getPostsWithAuthorsUseCase(NoParams());
    emit(response.fold((error) => PostsState.failed(message: error.message),
        (res) => PostsState.done(response: res)));
  }
}

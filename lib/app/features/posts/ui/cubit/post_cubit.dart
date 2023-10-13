import 'package:blog_app_case_study/app/features/posts/domain/get_posts_usecase.dart';
import 'package:blog_app_case_study/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({
    required GetPostsWithAuthorsUseCase getPostsWithAuthorsUseCase,
  })  : _getPostsWithAuthorsUseCase = getPostsWithAuthorsUseCase,
        super(const PostsState.unknown());

  final GetPostsWithAuthorsUseCase _getPostsWithAuthorsUseCase;

  Future<void> getPostsAuthors() async {
    emit(const PostsState.processing());

    final response = await _getPostsWithAuthorsUseCase();

    if (response.isFailure) {
      emit(PostsState.failed(message: response.errorMessage));
    } else {
      emit(PostsState.done(response: response.data!));
    }
  }
}

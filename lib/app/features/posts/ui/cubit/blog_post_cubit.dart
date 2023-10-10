import 'package:blog_app_case_study/app/features/posts/domain/get_blog_posts_usecase.dart';
import 'package:blog_app_case_study/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_post_state.dart';

class BlogPostsCubit extends Cubit<BlogPostsState> {
  BlogPostsCubit(
      {required GetBlogPostsWithAuthorsUseCase getPostsWithAuthorsUseCase})
      : _getPostsWithAuthorsUseCase = getPostsWithAuthorsUseCase,
        super(const BlogPostsState.unknown());

  final GetBlogPostsWithAuthorsUseCase _getPostsWithAuthorsUseCase;

  Future<void> getPostsAuthors() async {
    emit(const BlogPostsState.processing());

    final response = await _getPostsWithAuthorsUseCase();

    if (response.isFailure) {
      emit(BlogPostsState.failed(message: response.errorMessage));
    } else {
      emit(BlogPostsState.done(response: response.data!));
    }

    // emit(response.fold((error) => BlogPostsState.failed(message: error.message),
    //     (res) => BlogPostsState.done(response: res)));
  }
}

import 'package:blog_app_case_study/app/features/posts/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/app/features/search/data/repository/search_repository.dart';
import 'package:blog_app_case_study/core/data/result.dart';
import 'package:blog_app_case_study/core/utils/typedefs.dart';

class SearchPostsWithAuthorsUseCase {
  const SearchPostsWithAuthorsUseCase({
    required SearchPostsRepository searchPostsRepository,
    required PostsRepository postsRepository,
  })  : _searchPostsRepository = searchPostsRepository,
        _postsRepository = postsRepository;

  final SearchPostsRepository _searchPostsRepository;
  final PostsRepository _postsRepository;

  Future<Result<PostsWithAuthors>> call(String searchTerm) async {
    final authorsResult = await _postsRepository.getAuthors();
    final searchResult =
        await _searchPostsRepository.searchPostByTitle(searchTerm: searchTerm);

    if (searchResult.isFailure) {
      return Result.failure(errorMessage: searchResult.errorMessage);
    }

    if (authorsResult.isFailure) {
      return Result.failure(errorMessage: authorsResult.errorMessage);
    }

    final authors = authorsResult.data?.users;
    final posts = searchResult.data?.posts;

    final postsWithAuthors = (posts: posts, authors: authors);
    return Result.success(postsWithAuthors);
  }
}

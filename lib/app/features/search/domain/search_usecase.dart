import 'package:blog_app_case_study/app/features/posts/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/app/features/search/data/repository/search_repository.dart';
import 'package:blog_app_case_study/core/data/resource.dart';
import 'package:blog_app_case_study/core/utils/typedefs.dart';

class SearchPostsWithAuthorsUseCase {
  const SearchPostsWithAuthorsUseCase({
    required SearchPostsRepository searchPostsRepository,
    required PostsRepository postsRepository,
  })  : _searchPostsRepository = searchPostsRepository,
        _postsRepository = postsRepository;

  final SearchPostsRepository _searchPostsRepository;
  final PostsRepository _postsRepository;

  Future<Resource<PostsWithAuthors>> call(String searchTerm) async {
    final authorsResource = await _postsRepository.getAuthors();
    final searchResource =
        await _searchPostsRepository.searchPostByTitle(searchTerm: searchTerm);

    if (searchResource.isFailure) {
      return Resource.failure(errorMessage: searchResource.errorMessage);
    }

    if (authorsResource.isFailure) {
      return Resource.failure(errorMessage: authorsResource.errorMessage);
    }

    final authors = authorsResource.data?.users;
    final posts = searchResource.data?.posts;

    final postsWithAuthors = (posts: posts, authors: authors);
    return Resource.success(postsWithAuthors);
  }
}

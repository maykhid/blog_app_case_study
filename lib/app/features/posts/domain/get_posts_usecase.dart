import 'package:blog_app_case_study/app/features/posts/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/core/data/resource.dart';
import 'package:blog_app_case_study/core/utils/typedefs.dart';

class GetPostsWithAuthorsUseCase {
  const GetPostsWithAuthorsUseCase({
    required PostsRepository blogPostsRepository,
  }) : _postsRepository = blogPostsRepository;

  final PostsRepository _postsRepository;

  Future<Resource<PostsWithAuthors>> call() async {
    final authorsResource = await _postsRepository.getAuthors();
    final postsResource = await _postsRepository.getPosts();

    if (postsResource.isFailure) {
      return Resource.failure(errorMessage: postsResource.errorMessage);
    }

    if (authorsResource.isFailure) {
      return Resource.failure(errorMessage: authorsResource.errorMessage);
    }

    final authors = authorsResource.data?.users;
    final posts = postsResource.data?.posts;

    final postsWithAuthors = (posts: posts, authors: authors);
    return Resource.success(postsWithAuthors);
  }
}

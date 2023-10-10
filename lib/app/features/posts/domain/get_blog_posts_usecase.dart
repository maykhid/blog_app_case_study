import 'package:blog_app_case_study/app/features/posts/data/repository/blog_posts_repository.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/data/resource.dart';

class GetBlogPostsWithAuthorsUseCase {
  const GetBlogPostsWithAuthorsUseCase({
    required BlogPostsRepository blogPostsRepository,
  }) : _blogPostsRepository = blogPostsRepository;

  final BlogPostsRepository _blogPostsRepository;

  Future<Resource<PostsWithAuthors>> call() async {
    final authorsResource = await _blogPostsRepository.getAuthors();
    final postsResource = await _blogPostsRepository.getPosts();

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

typedef PostsWithAuthors = ({List<Post>? posts, List<Author>? authors});

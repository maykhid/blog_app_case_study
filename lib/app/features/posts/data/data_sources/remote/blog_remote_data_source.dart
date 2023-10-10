import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/blog_api.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';

class BlogPostsRemoteDataSource {
  const BlogPostsRemoteDataSource({required BlogApi blogApi})
      : _blogApi = blogApi;

  final BlogApi _blogApi;

  Future<PostsResponse> getPosts() => _blogApi.getPosts();
  Future<AuthorsResponse> getAuthors() => _blogApi.getAuthors();
}

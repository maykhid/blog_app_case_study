import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';

abstract class BlogApi {
  Future<AuthorsResponse> getAuthors();
  Future<PostsResponse> getPosts();
}

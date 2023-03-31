import 'package:blog_app_case_study/app/shared/models/authors_response.dart';

abstract class AuthorsDao {
  void cacheAuthors({required AuthorsResponse authors});
  bool get isAuthorsCacheAvailable;
  AuthorsResponse? getCachedAuthors();
}

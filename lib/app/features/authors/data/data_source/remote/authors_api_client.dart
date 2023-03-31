import 'package:blog_app_case_study/app/shared/models/authors_response.dart';

abstract class AuthorsApiClient {
  Future<AuthorsResponse> getAuthors();
}
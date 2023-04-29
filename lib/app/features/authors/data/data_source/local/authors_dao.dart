import '../../../../../shared/data/models/authors_response.dart';

abstract class AuthorsDao {
  void cacheAuthors({required AuthorsResponse authors});
  bool get isAuthorsCacheAvailable;
  AuthorsResponse? getCachedAuthors();
}

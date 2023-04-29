import '../../../../../shared/data/models/authors_response.dart';

abstract class AuthorsRemoteDataSource {
  Future<AuthorsResponse> getAuthors();
}

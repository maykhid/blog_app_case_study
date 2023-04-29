import 'package:dartz/dartz.dart';

import '../../../core/model/error/failure.dart';
import '../../../core/model/params/params.dart';
import '../../../core/utils/typedefs.dart';
import '../data/models/authors_response.dart';
import '../data/models/posts_response.dart';
import '../data/repository/repository.dart';


// abstract class GetPostsWithAuthorsUseCase<R1, R2> {
//   GetPostsWithAuthorsUseCase(
//     R1 r1,
//     R2 r2,
//   );

//   // PostsWithAuthors call() {
//   //   try
//   // }
//   PostsWithAuthors call(R1 r1, R2 r2);
// }

// class GetPostsWithAuthorsUseCaseForBookmark
//     extends GetPostsWithAuthorsUseCase<AuthorsRepository, BookmarkRepository> {
//   GetPostsWithAuthorsUseCaseForBookmark(AuthorsRepository authorsRepository,
//       BookmarkRepository bookmarkRepository)
//       : super(authorsRepository, bookmarkRepository);

//   @override
//   PostsWithAuthors call(r1, r2) {
//     // TODO: implement call
//     throw UnimplementedError();
//   }
// }

// class TestInject {
//   TestInject({required GetPostsWithAuthorsUseCase useCase})
//       : _useCase = useCase;

//   final GetPostsWithAuthorsUseCase _useCase;

//   void testUseCase() {
//     _useCase();
//   }
// }

// void main() {

// }
class GetPostsWithAuthorsUseCase<RepositoryAuthorResponse extends IRepository, RepositoryPostResponse extends IRepository> {
  /// [RepositoryAuthorResponse] is the repository that returns authors
  /// [RepositoryPostResponse] is the repository that returns posts
  GetPostsWithAuthorsUseCase({
    required RepositoryAuthorResponse authorsRepository,
    required RepositoryPostResponse postsRepository,
  })  : _authorsRepository = authorsRepository,
        _postsRepository = postsRepository;

  final RepositoryAuthorResponse _authorsRepository;
  final RepositoryPostResponse _postsRepository;

  Future<Either<Failure, PostsWithAuthors>> call(Params params) async {
    try {
      final Either<Failure, AuthorsResponse> authorsOrFailure =
          await _authorsRepository();

      final Either<Failure, PostsResponse> postsOrFailure =
          await _postsRepository(params.searchTerm);

      if (authorsOrFailure.isLeft()) {
        final left = authorsOrFailure.fold(
          (failure) => failure,
          (_) {
            throw Exception('No left value found!');
          },
        );
        return Left(left);
      }

      if (postsOrFailure.isLeft()) {
        final left = postsOrFailure.fold((failure) => failure, (_) {
          throw Exception('No left value found!');
        });
        return Left(left);
      }

      final authors = authorsOrFailure.fold((_) {}, (authors) => authors);
      final posts = postsOrFailure.fold((_) {}, (posts) => posts);

      return Right(PostsWithAuthors(posts!, authors!));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString(), code: '0'));
    }
  }
}

// Future<void> main(List<String> args) async {
//    Box<AuthorsResponse> authorsBox = await Hive.openBox<AuthorsResponse>('usersBox');
//   AuthorsRepository authorsRepository = AuthorsRepository(authorsRemoteDataSource: HttpAuthorsRemoteDataSource(client: HttpClient(httpClient: Client())), authorsDao: HiveAuthorsDao(authorsBox: authorsBox));
//   PostRepository postRepository;
//   final uuub = GetPostsWithAuthorsUseCase<AuthorsRepository, PostRepository>(authorsRepository, postRepository);

//   await uuub(authorsRepository, postRepository);
// }

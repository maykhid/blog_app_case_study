import 'package:dartz/dartz.dart';

import '../../../core/model/error/failure.dart';
import '../../../core/utils/typedefs.dart';
import '../models/authors_response.dart';
import '../models/posts_response.dart';

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
class GetPostsWithAuthorsUseCase<R1, R2> {
  /// [R1] is the repository for authors
  /// [R2] is the repository for posts
  GetPostsWithAuthorsUseCase({
    required R1 authorsRepository,
    required R2 postsRepository,
  })  : _authorsRepository = authorsRepository,
        _postsRepository = postsRepository;

  final R1 _authorsRepository;
  final R2 _postsRepository;

  Future<Either<Failure, PostsWithAuthors>> call([String? searchTerm]) async {
    try {
      final Either<Failure, AuthorsResponse> authorsOrFailure =
          await _authorsRepository!();

      final Either<Failure, PostsResponse> postsOrFailure =
          await _postsRepository!(searchTerm);

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

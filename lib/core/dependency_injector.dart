import 'package:blog_app_case_study/app/features/authors/data/data_source/local/authors_dao.dart';
import 'package:blog_app_case_study/app/features/authors/data/data_source/local/hive_authors_dao.dart';
import 'package:blog_app_case_study/app/features/authors/data/data_source/remote/authors_remote_data_source.dart';
import 'package:blog_app_case_study/app/features/authors/data/data_source/remote/http_authors_remote_data_source.dart';
import 'package:blog_app_case_study/app/features/home/data/data_source/remote/posts_remote_data_source.dart';
import 'package:blog_app_case_study/app/shared/domain/get_posts_with_authors_usecase.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/client/client.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/client/http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';

import '../app/features/authors/data/repository/authors_repository.dart';
import '../app/features/bookmark/data/data_source/local/bookmark_dao.dart';
import '../app/features/bookmark/data/data_source/local/hive_bookmark_dao.dart';
import '../app/features/bookmark/data/repository/bookmark_repository.dart';
import '../app/features/home/data/data_source/local/hive_posts_dao.dart';
import '../app/features/home/data/data_source/local/posts_dao.dart';
import '../app/features/home/data/data_source/remote/http_posts_remote_data_source.dart';
import '../app/features/home/data/repository/posts_repository.dart';
import '../app/features/search/data/repository/search_repository.dart';
import '../app/features/search/ui/cubits/search_cubit.dart';
import '../app/shared/data/models/authors_response.dart';
import '../app/shared/data/models/posts_response.dart';
import 'router/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // global blocs
  di.registerFactory<SearchCubit>(() => SearchCubit(getPostsWithAuthorsUseCase: di()));

  di.registerLazySingleton(() => Client());

  // clients
  di.registerLazySingleton<IClient>(() => HttpClient(httpClient: di()));

  //usecases
  // di.registerLazySingleton<GetPostsWithAuthorsUseCase>(() =>
  //     GetPostsWithAuthorsUseCase(
  //         authorsRepository: di(), postsRepository: di()));

  // // get boookmarks usecase

  di.registerFactory<
      GetPostsWithAuthorsUseCase<AuthorsRepository, BookmarkRepository>>(
    () => GetPostsWithAuthorsUseCase<AuthorsRepository, BookmarkRepository>(
      authorsRepository: di(),
      postsRepository: di(),
    ),
  );

  // get homeposts usecase

  di.registerFactory<
      GetPostsWithAuthorsUseCase<AuthorsRepository, PostRepository>>(
    () => GetPostsWithAuthorsUseCase<AuthorsRepository, PostRepository>(
      authorsRepository: di(),
      postsRepository: di(),
    ),
  );

  // get search usecase

  di.registerFactory<
          GetPostsWithAuthorsUseCase<AuthorsRepository, SearchRepository>>(
      () => GetPostsWithAuthorsUseCase<AuthorsRepository, SearchRepository>(
          authorsRepository: di(), postsRepository: di()));

  // repos
  di.registerLazySingleton<PostRepository>(
      () => PostRepository(postDao: di(), postsRemoteDataSource: di()));
  di.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepository(bookmarkDao: di()));
  di.registerLazySingleton<SearchRepository>(() => SearchRepository(
        postsDao: di(),
        postsRemoteDataSource: di(),
      ));
  di.registerLazySingleton<AuthorsRepository>(() => AuthorsRepository(
        authorsRemoteDataSource: di(),
        authorsDao: di(),
      ));

  // data
  // --- local
  di.registerLazySingleton<BookmarkDao>(() => HiveBookmarkDao(postBox: di()));
  di.registerLazySingleton<PostsDao>(() => HivePostDao(postsBox: di()));
  di.registerLazySingleton<AuthorsDao>(() => HiveAuthorsDao(authorsBox: di()));

  di.registerLazySingleton<AuthorsRemoteDataSource>(
      () => HttpAuthorsRemoteDataSource(client: di()));
  di.registerLazySingleton<PostsRemoteDataSource>(
      () => HttpPostsRemoteDataSource(client: di()));


  // external
  // di.registerLazySingleton<IClient>(
  //     () => HttpClient(httpClient: di()));

  // --- open and register bookmarkedPosts box
  final bookmarkBox = await Hive.openBox<Post>('bookmarkBox');
  di.registerLazySingleton(() => bookmarkBox);

  // --- open and register posts box
  final postsBox = await Hive.openBox<PostsResponse>('postsBox');
  di.registerLazySingleton(() => postsBox);

  // --- open and register users box
  final usersBox = await Hive.openBox<AuthorsResponse>('usersBox');
  di.registerLazySingleton(() => usersBox);

  // core
  di.registerLazySingleton(() => NavigationService());
}

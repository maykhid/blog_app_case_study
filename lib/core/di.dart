import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/hive_posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/http_posts_api.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/posts_api.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/posts_remote_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/app/features/posts/domain/get_posts_usecase.dart';
import 'package:blog_app_case_study/app/features/search/data/repository/search_repository.dart';
import 'package:blog_app_case_study/app/features/search/domain/search_usecase.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/router/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

GetIt di = GetIt.instance;

Future<void> setup() async {
  di
    ..registerLazySingleton<PostsApi>(HttpPostsApi.new)
    ..registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSource(postsApi: di()),
    )
    ..registerLazySingleton<PostsLocalDataSource>(
      () => HiveBlogPostsLocalDataSource(postsBox: di(), authorsBox: di()),
    )
    ..registerLazySingleton<PostsRepository>(
      () => PostsRepository(
        postsRemoteDataSource: di(),
        postsLocalDataSource: di(),
      ),
    )
    ..registerLazySingleton<SearchPostsRepository>(
      () => SearchPostsRepository(
        postsRepository: di(),
      ),
    )
    ..registerLazySingleton<GetPostsWithAuthorsUseCase>(
      () => GetPostsWithAuthorsUseCase(
        blogPostsRepository: di(),
      ),
    )
    ..registerLazySingleton<SearchPostsWithAuthorsUseCase>(
      () => SearchPostsWithAuthorsUseCase(
        postsRepository: di(),
        searchPostsRepository: di(),
      ),
    );

  // --- open and register posts box
  final postsBox = await Hive.openBox<PostsResponse>('postsBox');
  di.registerLazySingleton(() => postsBox);

  // --- open and register users box
  final usersBox = await Hive.openBox<AuthorsResponse>('usersBox');
  di
    ..registerLazySingleton(() => usersBox)

    // core
    ..registerLazySingleton(NavigationService.new);
}

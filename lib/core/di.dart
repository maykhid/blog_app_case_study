import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/blog_posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/hive_blog_posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/blog_api.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/http_blog_api.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/blog_remote_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/repository/blog_posts_repository.dart';
import 'package:blog_app_case_study/app/features/posts/domain/get_blog_posts_usecase.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/router/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

GetIt di = GetIt.instance;

Future<void> setup() async {
  di.registerLazySingleton<BlogApi>(() => HttpBlogApi());

  di.registerLazySingleton<BlogPostsRemoteDataSource>(
      () => BlogPostsRemoteDataSource(blogApi: di()));

  di.registerLazySingleton<BlogPostsLocalDataSource>(
      () => HiveBlogPostsLocalDataSource(postsBox: di(), authorsBox: di()));

  di.registerLazySingleton<BlogPostsRepository>(() => BlogPostsRepository(
      blogPostsRemoteDataSource: di(), blogPostsLocalDataSource: di()));

  di.registerLazySingleton<GetBlogPostsWithAuthorsUseCase>(
      () => GetBlogPostsWithAuthorsUseCase(
            blogPostsRepository: di(),
          ));

  // --- open and register posts box
  final postsBox = await Hive.openBox<PostsResponse>('postsBox');
  di.registerLazySingleton(() => postsBox);

  // --- open and register users box
  final usersBox = await Hive.openBox<AuthorsResponse>('usersBox');
  di.registerLazySingleton(() => usersBox);

  // core
  di.registerLazySingleton(() => NavigationService());
}

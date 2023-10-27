import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/posts_local_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/posts_remote_data_source.dart';
import 'package:blog_app_case_study/app/features/posts/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PostsLocalDataSource>(),
  MockSpec<PostsRemoteDataSource>(),
])
void main() {
  final mockPostsLocalDataSource = MockPostsLocalDataSource();
  final mockPostsRemoteDataSource = MockPostsRemoteDataSource();

  final postsRepository = PostsRepository(
    postsRemoteDataSource: mockPostsRemoteDataSource,
    postsLocalDataSource: mockPostsLocalDataSource,
  );

  test('get posts', () async {
    when(mockPostsRemoteDataSource.getPosts()).thenAnswer((_) {
      return Future.value(const PostsResponse(posts: []));
    });

    when(
      mockPostsLocalDataSource.updatePosts(
        posts: const PostsResponse(posts: []),
      ),
    ).thenAnswer((_) {});

    when(mockPostsLocalDataSource.getPosts()).thenAnswer((_) {
      return const PostsResponse(posts: []);
    });

    final response = await postsRepository.getPosts();

    verify(mockPostsRemoteDataSource.getPosts()).called(1);
    verify(mockPostsLocalDataSource.getPosts()).called(1);
    verify(
      mockPostsLocalDataSource.updatePosts(
        posts: const PostsResponse(posts: []),
      ),
    ).called(1);

    expect(response.data, const PostsResponse(posts: []));
  });

  test('get authors', () async {
    when(mockPostsRemoteDataSource.getAuthors()).thenAnswer((_) {
      return Future.value(const AuthorsResponse(users: []));
    });

    when(
      mockPostsLocalDataSource.updateAuthors(
        authors: const AuthorsResponse(users: []),
      ),
    ).thenAnswer((_) {});

    when(mockPostsLocalDataSource.getAuthors()).thenAnswer((_) {
      return const AuthorsResponse(users: []);
    });

    final response = await postsRepository.getAuthors();

    verify(mockPostsRemoteDataSource.getAuthors()).called(1);
    verify(mockPostsLocalDataSource.getAuthors()).called(1);
    verify(
      mockPostsLocalDataSource.updateAuthors(
        authors: const AuthorsResponse(users: []),
      ),
    ).called(1);

    expect(
      response.data,
      const AuthorsResponse(users: []),
    );
  });

  test('get local posts if remote fails', () async {
    when(mockPostsRemoteDataSource.getPosts()).thenAnswer((_) {
      throw Exception();
    });

    when(mockPostsLocalDataSource.isPostsAvailable).thenAnswer((_) => true);

    when(mockPostsLocalDataSource.getPosts()).thenAnswer((_) {
      return const PostsResponse(posts: []);
    });

    final response = await postsRepository.getPosts();

    verify(mockPostsRemoteDataSource.getPosts()).called(1);
    verify(mockPostsLocalDataSource.getPosts()).called(1);

    expect(response.data, const PostsResponse(posts: []));
  });

  test('get local authors if remote fails', () async {
    when(mockPostsRemoteDataSource.getAuthors()).thenAnswer((_) {
      throw Exception();
    });

    when(mockPostsLocalDataSource.isAuthorsAvailable).thenAnswer((_) => true);

    when(mockPostsLocalDataSource.getAuthors()).thenAnswer((_) {
      return const AuthorsResponse(users: []);
    });

    final response = await postsRepository.getAuthors();

    verify(mockPostsRemoteDataSource.getAuthors()).called(1);
    verify(mockPostsLocalDataSource.getAuthors()).called(1);

    expect(
      response.data,
      const AuthorsResponse(users: []),
    );
  });
}

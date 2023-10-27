import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/dao/hive_posts_dao.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/posts_local_data_source.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'posts_local_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HivePostsDao>(),
])
void main() {
  final mockHivePostDao = MockHivePostsDao();
  final postsLocalDataSource = PostsLocalDataSource(postsDao: mockHivePostDao);
  const mockAuthors = AuthorsResponse(users: []);
  const mockPosts = PostsResponse(posts: []);

  group('Test Posts Local Data Source', () {
    test('-- update Authors', () {
      when(mockHivePostDao.cacheAuthors(authors: mockAuthors))
          .thenAnswer((_) {});
      postsLocalDataSource.updateAuthors(authors: mockAuthors);
      verify(mockHivePostDao.cacheAuthors(authors: mockAuthors)).called(1);
    });

    test('-- update Posts', () {
      when(mockHivePostDao.cachePosts(posts: mockPosts)).thenAnswer((_) {});
      postsLocalDataSource.updatePosts(posts: mockPosts);
      verify(mockHivePostDao.cachePosts(posts: mockPosts)).called(1);
    });

    test('-- get Posts', () {
      when(mockHivePostDao.getCachedPosts()).thenAnswer((_) => mockPosts);
      final posts = postsLocalDataSource.getPosts();
      verify(mockHivePostDao.getCachedPosts()).called(1);
      expect(posts, mockPosts);
    });

    test('-- get Authors', () {
      when(mockHivePostDao.getCachedAuthors()).thenAnswer((_) => mockAuthors);
      final authors = postsLocalDataSource.getAuthors();
      verify(mockHivePostDao.getCachedAuthors()).called(1);
      expect(authors, mockAuthors);
    });

    test('-- is Authors cache available', () {
      when(mockHivePostDao.isAuthorsCacheAvailable).thenAnswer((_) => true);
      final isAuthorsAvailable = postsLocalDataSource.isAuthorsAvailable;
      verify(mockHivePostDao.isAuthorsCacheAvailable).called(1);
      expect(isAuthorsAvailable, true);
    });

    test('-- is Posts cache available', () {
      when(mockHivePostDao.isPostsCacheAvailable).thenAnswer((_) => true);
      final isPostsAvailable = postsLocalDataSource.isPostsAvailable;
      verify(mockHivePostDao.isPostsCacheAvailable).called(1);
      expect(isPostsAvailable, true);
    });
  });
}

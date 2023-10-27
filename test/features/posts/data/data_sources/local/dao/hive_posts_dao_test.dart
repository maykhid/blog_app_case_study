import 'package:blog_app_case_study/app/features/posts/data/data_sources/local/dao/hive_posts_dao.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_posts_dao_test.mocks.dart';

// class MockHiveInterface extends Mock implements HiveInterface {}

// class MockPostsBox extends Mock implements Box<PostsResponse> {}

// class MockAuthorsBox extends Mock implements Box<AuthorsResponse> {}

@GenerateNiceMocks([
  MockSpec<HiveInterface>(),
  // ignore: strict_raw_type
  MockSpec<Box>(),
])
void main() {
  const mockAuthors = AuthorsResponse(users: []);
  const mockPosts = PostsResponse(posts: []);

  const postsKey = '__posts__key__';
  const authorsKey = '__authors__key__';
  const authorsBoxName = 'authorsBox';
  const postsBoxName = 'postsBox';

  group('test hive posts dao methods', () {
    final mockHiveInterface = MockHiveInterface();
    final mockPostsBox = MockBox<PostsResponse>();
    final mockAuthorsBox = MockBox<AuthorsResponse>();

    final hivePostsDao =
        HivePostsDao(postsBox: mockPostsBox, authorsBox: mockAuthorsBox);

    when(mockHiveInterface.openBox<PostsResponse>(postsBoxName))
        .thenAnswer((_) => Future.value(mockPostsBox));

    when(mockHiveInterface.openBox<AuthorsResponse>(authorsBoxName))
        .thenAnswer((_) => Future.value(mockAuthorsBox));

    test('-- cache Authors', () async {
      final box =
          await mockHiveInterface.openBox<AuthorsResponse>(authorsBoxName);
      when(
        box.put(
          authorsKey,
          mockAuthors,
        ),
      ).thenAnswer((invocation) => Future.value());

      hivePostsDao.cacheAuthors(authors: mockAuthors);
      verify(
        mockHiveInterface.openBox<AuthorsResponse>(authorsBoxName),
      ).called(1);
      verify(mockAuthorsBox.put(authorsKey, mockAuthors)).called(1);
    });

    test('-- cache Posts', () async {
      final box = await mockHiveInterface.openBox<PostsResponse>(postsBoxName);
      when(
        box.put(
          postsKey,
          mockPosts,
        ),
      ).thenAnswer((invocation) => Future.value());

      hivePostsDao.cachePosts(posts: mockPosts);
      verify(mockHiveInterface.openBox<PostsResponse>(postsBoxName));
      verify(mockPostsBox.put(postsKey, mockPosts));
    });

    test('-- get cached Posts', () async {
      final box = await mockHiveInterface.openBox<PostsResponse>(postsBoxName);

      when(box.get(postsKey)).thenAnswer((_) => mockPosts);
      final posts = hivePostsDao.getCachedPosts();
      expect(posts, mockPosts);
    });

    test('-- get cached Authors', () async {
      final box =
          await mockHiveInterface.openBox<AuthorsResponse>(authorsBoxName);

      when(box.get(authorsKey)).thenAnswer((_) => mockAuthors);
      final authors = hivePostsDao.getCachedAuthors();
      expect(authors, mockAuthors);
    });
  });
}

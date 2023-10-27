import 'dart:convert';

import 'package:blog_app_case_study/app/features/posts/data/repository/posts_repository.dart';
import 'package:blog_app_case_study/app/features/search/data/repository/search_repository.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/data/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../posts/data/data_sources/remote/api/posts_json.dart';
import 'search_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostsRepository>()])
void main() {
  final mockPostsRepository = MockPostsRepository();
  final searchRepository =
      SearchPostsRepository(postsRepository: mockPostsRepository);

  const searchTerm = 'cum';
  final postsResponse = PostsResponse.fromJson(jsonDecode(postsJson) as List);

  /// get mock search results from known input
  final mockSearchResults = postsResponse.posts
      .where((post) => post.title.toLowerCase().contains(searchTerm))
      .toList();

  test('get search ', () async {
    when(mockPostsRepository.getPosts()).thenAnswer((_) {
      return Future.value(Result.success(postsResponse));
    });

    final searchResults =
        await searchRepository.searchPostByTitle(searchTerm: searchTerm);

    verify(mockPostsRepository.getPosts()).called(1);

    expect(searchResults.data!.posts, mockSearchResults);
  });
}

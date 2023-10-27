import 'dart:convert';

import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/http_posts_api.dart';
import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/core/data/data_source/remote/api_configs.dart';
import 'package:blog_app_case_study/core/data/model/error/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_post_api_test.mocks.dart';
import 'posts_json.dart';
import 'users_json.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  final client = MockClient();
  final httpPostsApi = HttpPostsApi(client: client);

  const postsPath = '/posts';
  const usersPath = '/users';
  final headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  void setUpGetUsersSuccess200() {
    when(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, usersPath),
        headers: headers,
      ),
    ).thenAnswer((_) async => http.Response(usersJson, 200));
  }

  void setUpGetPostsSuccess200() {
    when(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, postsPath),
        headers: headers,
      ),
    ).thenAnswer((_) async => http.Response(postsJson, 200));
  }

  void setUpGetUsersFailure404() {
    when(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, usersPath),
        headers: headers,
      ),
    ).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpGetPostsFailure404() {
    when(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, postsPath),
        headers: headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        'Something went wrong',
        404,
      ),
    );
  }

  test('get posts success', () async {
    setUpGetPostsSuccess200();

    final postsResponse = await httpPostsApi.getPosts();

    verify(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, postsPath),
        headers: headers,
      ),
    ).called(1);
    expect(
      postsResponse,
      PostsResponse.fromJson(jsonDecode(postsJson) as List),
    );
  });

  test('get users success', () async {
    setUpGetUsersSuccess200();

    final authorsResponse = await httpPostsApi.getAuthors();

    verify(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, usersPath),
        headers: headers,
      ),
    ).called(1);

    expect(
      authorsResponse,
      AuthorsResponse.fromJson(jsonDecode(usersJson) as List),
    );
  });

  test('get posts failure', () async {
    setUpGetPostsFailure404();

    final request = httpPostsApi.getPosts();

    verify(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, postsPath),
        headers: headers,
      ),
    ).called(1);

    expect(
      request,
      throwsA(const TypeMatcher<ClientException>()),
    );
  });

  test('get users failure', () async {
    setUpGetUsersFailure404();

    final request = httpPostsApi.getAuthors();

    verify(
      client.get(
        Uri.https(ApiConfigs.jsonPlaceholderUrl, usersPath),
        headers: headers,
      ),
    ).called(1);

    expect(
      request,
      throwsA(const TypeMatcher<ClientException>()),
    );
  });
}

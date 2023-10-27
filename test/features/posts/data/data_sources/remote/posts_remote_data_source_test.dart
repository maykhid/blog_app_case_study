import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/api/http_posts_api.dart';
import 'package:blog_app_case_study/app/features/posts/data/data_sources/remote/posts_remote_data_source.dart';
import 'package:mockito/annotations.dart';

import 'posts_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpPostsApi>(),
])
void main() {
  final mockHttpPostsApi = MockHttpPostsApi();
  final postsRemoteDataSource =
      PostsRemoteDataSource(postsApi: mockHttpPostsApi);
}

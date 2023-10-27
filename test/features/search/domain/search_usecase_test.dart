import 'package:blog_app_case_study/app/features/search/domain/search_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'search_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SearchPostsWithAuthorsUseCase>(),
])
void main() {
  final searchUseCase = MockSearchPostsWithAuthorsUseCase();

  group('Test Search use case', () {

    test('', () {
      // when(searchUseCase())
    });
  });
}

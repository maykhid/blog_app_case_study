import 'package:blog_app_case_study/app/features/authors/data/data_source/local/authors_dao.dart';
import 'package:blog_app_case_study/app/shared/models/authors_response.dart';
import 'package:blog_app_case_study/core/model/error/exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveAuthorsDao implements AuthorsDao {
  final Box<AuthorsResponse> _authorsBox;

  HiveAuthorsDao({required Box<AuthorsResponse> authorsBox})
      : _authorsBox = authorsBox;

  static const String _authorsKey = "__authors__key__";

  @override
  void cacheAuthors({required AuthorsResponse authors}) =>
      _authorsBox.put(_authorsKey, authors).onError((error, stackTrace) => throw LocalStorageException("Caching authors failed: ${error.toString()}"));

  @override
  AuthorsResponse? getCachedAuthors() => _authorsBox.get(_authorsKey);

  @override
  bool get isAuthorsCacheAvailable => _authorsBox.isNotEmpty;
}

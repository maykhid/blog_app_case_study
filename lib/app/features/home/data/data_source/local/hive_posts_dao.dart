import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../../core/model/error/exception.dart';

import '../../../../../shared/data/models/posts_response.dart';
import 'posts_dao.dart';

class HivePostDao implements PostsDao {
  final Box<PostsResponse> _postsBox;

  HivePostDao({required Box<PostsResponse> postsBox}) : _postsBox = postsBox;

  static const String _postKey = '__posts__key__';

  @override
  void cachePosts({required PostsResponse posts}) =>
      _postsBox.put(_postKey, posts).onError(
          (error, stackTrace) => throw LocalStorageException("Caching posts failed: ${error.toString()}"));

  @override
  PostsResponse? getCachedPosts() => _postsBox.get(_postKey);

  @override
  bool get isPostsCacheAvailable => _postsBox.isNotEmpty;
}

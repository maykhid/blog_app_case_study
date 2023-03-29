import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../shared/models/posts.dart';
import 'posts_dao.dart';

class HivePostDao implements PostsDao {
  final Box<Posts> _postsBox;

  HivePostDao({required Box<Posts> postsBox}) : _postsBox = postsBox;

  static const String _postKey = '__posts__key__';

  @override
  void cachePosts({required Posts posts}) => _postsBox.put(_postKey, posts);

  @override
  Posts? getCachedPosts() => _postsBox.get(_postKey);

  @override
  bool get isPostsCacheAvailable => _postsBox.isNotEmpty;
}

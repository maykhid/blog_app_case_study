import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../shared/models/posts_response.dart';
import 'bookmark_dao.dart';

class HiveBookmarkDao implements BookmarkDao {
  final Box<Post> _postBox;

  HiveBookmarkDao({required Box<Post> postBox}) : _postBox = postBox;

  @override
  void clearBookmarkedPost({required int index}) => _postBox.deleteAt(index);

  @override
  void bookmarkPost({required Post post}) => _postBox.add(post);

  @override
  PostsResponse? getAllBookmarkedPosts() => PostsResponse(posts: _postBox.values.toList());
}

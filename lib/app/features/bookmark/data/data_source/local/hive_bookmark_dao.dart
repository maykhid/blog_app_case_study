import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../../core/model/error/exception.dart';
import '../../../../../shared/models/posts_response.dart';
import 'bookmark_dao.dart';

class HiveBookmarkDao implements BookmarkDao {
  final Box<Post> _postBox;

  HiveBookmarkDao({required Box<Post> postBox}) : _postBox = postBox;

  @override
  void clearBookmarkedPost({required int index}) =>
      _postBox.deleteAt(index).onError(
          (error, stackTrace) => throw LocalStorageException("Clearing bookmark failed: ${error.toString()}"));

  @override
  void bookmarkPost({required Post post}) => _postBox.add(post).onError(
      (error, stackTrace) => throw LocalStorageException("Bookmark post failed: ${error.toString()}"));

  @override
  PostsResponse? getAllBookmarkedPosts() =>
      PostsResponse(posts: _postBox.values.toList());
}

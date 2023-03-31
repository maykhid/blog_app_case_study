import '../../../../../shared/models/posts_response.dart';

abstract class BookmarkDao {
  void bookmarkPost({required Post post});

  void clearBookmarkedPost({required int index});

  PostsResponse? getAllBookmarkedPosts();
}

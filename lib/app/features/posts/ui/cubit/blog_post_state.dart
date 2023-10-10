part of 'blog_post_cubit.dart';

class BlogPostsState extends Equatable {
  const BlogPostsState.unknown() : this._();

  const BlogPostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const BlogPostsState.done({required PostsWithAuthors response})
      : this._(
          status: DataResponseStatus.success,
          postsAuthorsResponse: response,
        );

  const BlogPostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);
  const BlogPostsState._({
    this.message,
    this.postsAuthorsResponse,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final PostsWithAuthors? postsAuthorsResponse;

  @override
  List<Object?> get props => [status, message, postsAuthorsResponse];
}

part of 'post_cubit.dart';

class PostsState extends Equatable {
  const PostsState.unknown() : this._();

  const PostsState.processing() : this._(status: DataResponseStatus.processing);

  const PostsState.done({required PostsWithAuthors response})
      : this._(
          status: DataResponseStatus.success,
          postsAuthorsResponse: response,
        );

  const PostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);
  const PostsState._({
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

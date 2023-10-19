part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState.unknown() : this._();

  const SearchState.processing()
      : this._(status: DataResponseStatus.processing);

  const SearchState.done({required PostsWithAuthors response})
      : this._(
          status: DataResponseStatus.success,
          postsAuthorsResponse: response,
        );

  const SearchState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);
  const SearchState._({
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

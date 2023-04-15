import 'package:blog_app_case_study/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums.dart';

class SearchState extends Equatable {
  const SearchState._({
    this.message,
    this.searchResponse,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final PostsWithAuthors? searchResponse;

  const SearchState.unknown() : this._();

  const SearchState.processing()
      : this._(status: DataResponseStatus.processing);

  const SearchState.done({required PostsWithAuthors? response})
      : this._(status: DataResponseStatus.success, searchResponse: response);

  const SearchState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, searchResponse];
}
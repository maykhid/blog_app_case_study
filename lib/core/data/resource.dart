class Resource<T> {
  Resource._(this.data);

  factory Resource.success(T? data) = _Success<T>;

  factory Resource.failure({String? errorMessage, T? data}) = _Failure<T>;

  factory Resource.loading() = _Loading<T>;

  bool get isSuccess => this is _Success<T>;
  bool get isLoading => this is _Loading<T>;
  bool get isFailure => this is _Failure<T?>;

  final T? data;

   // Getter method to access the error message
  String? get errorMessage {
    if (isFailure) {
      return (this as _Failure).errorMessage;
    }
    return null;
  }
}

class _Success<T> extends Resource<T> {
  _Success(T? data) : super._(data);
}

class _Loading<T> extends Resource<T> {
  _Loading() : super._(null);
}

class _Failure<T> extends Resource<T> {
  _Failure({this.errorMessage, T? data}) : super._(data);

  @override
  final String? errorMessage;
}

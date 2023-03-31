class ServerException implements Exception {
  ServerException(this.message, this.code);
  final String? message;
  final int? code;

  @override
  String toString() => 'ServerException (Message >> $message - ErrorCode >> $code)';
}

class LocalStorageException implements Exception {
  LocalStorageException(this.message, this.code);
  final String? message;
  final int? code;

  @override
  String toString() => 'LocalStorageException (Message >> $message - ErrorCode >> $code)';
}



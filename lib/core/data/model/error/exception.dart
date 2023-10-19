class ServerException implements Exception {
  ServerException(this.message, this.code);
  final String? message;
  final int? code;

  @override
  String toString() =>
      'ServerException (Message >> $message - ErrorCode >> $code)';
}

class ClientException implements Exception {
  ClientException(this.message, this.code);
  final String? message;
  final int? code;

  @override
  String toString() =>
      'ClientException (Message >> $message - ErrorCode >> $code)';
}

class LocalStorageException implements Exception {
  LocalStorageException(this.message);
  final String? message;

  @override
  String toString() => 'LocalStorageException (Message >> $message)';
}

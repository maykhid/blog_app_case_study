import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // const Failure();

  const Failure({this.code, this.message});
  final String? code;
  final String? message;

  @override
  List<Object?> get props => [code, message];
}

class ServerFailure extends Failure {
  const ServerFailure({String? code, String? message})
      : super(code: code, message: message);
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({String? code, String? message})
      : super(code: code, message: message);
}
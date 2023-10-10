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
  const ServerFailure({super.code, super.message});
}

class ClientFailure extends Failure {
  const ClientFailure({super.code, super.message});
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({super.code, super.message});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.code, super.message});
}

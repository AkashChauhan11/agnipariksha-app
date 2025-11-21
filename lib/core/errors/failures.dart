import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;
  const Failure(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, super.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
  }

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, super.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, super.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message, super.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, super.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}


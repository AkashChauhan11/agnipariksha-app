import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  
  const ServerException(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  const NetworkException(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class ValidationException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  const ValidationException(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class UnauthorizedException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  const UnauthorizedException(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  const CacheException(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}


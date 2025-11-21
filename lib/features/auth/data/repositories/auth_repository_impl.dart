import 'package:agni_pariksha/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<DataMap> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final result = await remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<DataMap> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result);
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message, e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<DataMap> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final result = await remoteDataSource.verifyOtp(
        email: email,
        otp: otp,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode      ));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<DataMap> resendOtp({
    required String email,
  }) async {
    try {
      final result = await remoteDataSource.resendOtp(email: email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<DataMap> forgotPassword({
    required String email,
  }) async {
    try {
      final result = await remoteDataSource.forgotPassword(email: email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<DataMap> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final result = await remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, e.statusCode));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred', 500));
    }
  }

  @override
  ResultFuture<User> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(CacheFailure('Failed to get user', 500));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(CacheFailure('Failed to logout', 500));
    }
  }
}


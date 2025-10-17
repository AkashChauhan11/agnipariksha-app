import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  });

  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Map<String, dynamic>>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Map<String, dynamic>>> resendOtp({
    required String email,
  });

  Future<Either<Failure, User>> getCurrentUser();
  
  Future<Either<Failure, void>> logout();
}


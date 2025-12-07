import 'package:agni_pariksha/utils/typedef.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  ResultFuture<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
    required String? state,
    required String? city,
  });

  ResultFuture<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  ResultFuture<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  });

  ResultFuture<Map<String, dynamic>> resendOtp({required String email});

  ResultFuture<Map<String, dynamic>> forgotPassword({required String email});

  ResultFuture<Map<String, dynamic>> verifyResetOtp({
    required String email,
    required String otp,
  });

  ResultFuture<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
  });

  ResultFuture<User> getCurrentUser();

  ResultFuture<User> getProfile();

  ResultVoid logout();
}

//

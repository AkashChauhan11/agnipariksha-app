import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class ResetPasswordUsecase extends UsecaseWithParams<Map<String, dynamic>, ResetPasswordParams> {
  //constructor injection of the auth repository
  const ResetPasswordUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<Map<String, dynamic>> call(ResetPasswordParams params) async => 
      _repository.resetPassword(
        email: params.email,
        otp: params.otp,
        newPassword: params.newPassword,
      );
}

class ResetPasswordParams extends Equatable {
  final String email;
  final String otp;
  final String newPassword;

  //constructor
  const ResetPasswordParams({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, otp, newPassword];
}


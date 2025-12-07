import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class VerifyResetOtpUsecase
    extends UsecaseWithParams<Map<String, dynamic>, VerifyResetOtpParams> {
  //constructor injection of the auth repository
  const VerifyResetOtpUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;

  @override
  ResultFuture<Map<String, dynamic>> call(VerifyResetOtpParams params) async =>
      _repository.verifyResetOtp(email: params.email, otp: params.otp);
}

class VerifyResetOtpParams extends Equatable {
  final String email;
  final String otp;

  //constructor
  const VerifyResetOtpParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}

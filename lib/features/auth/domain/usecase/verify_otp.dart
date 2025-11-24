import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class VerifyOtpUsecase extends UsecaseWithParams<Map<String, dynamic>, VerifyOtpParams> {
  //constructor injection of the auth repository
  const VerifyOtpUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<Map<String, dynamic>> call(VerifyOtpParams params) async => 
      _repository.verifyOtp(email: params.email, otp: params.otp);
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String otp;

  //constructor
  const VerifyOtpParams({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}


import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class ResendOtpUsecase extends UsecaseWithParams<Map<String, dynamic>, ResendOtpParams> {
  //constructor injection of the auth repository
  const ResendOtpUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<Map<String, dynamic>> call(ResendOtpParams params) async => 
      _repository.resendOtp(email: params.email);
}

class ResendOtpParams extends Equatable {
  final String email;

  //constructor
  const ResendOtpParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}


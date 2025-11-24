import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class ForgotPasswordUsecase extends UsecaseWithParams<Map<String, dynamic>, ForgotPasswordParams> {
  //constructor injection of the auth repository
  const ForgotPasswordUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<Map<String, dynamic>> call(ForgotPasswordParams params) async => 
      _repository.forgotPassword(email: params.email);
}

class ForgotPasswordParams extends Equatable {
  final String email;

  //constructor
  const ForgotPasswordParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}


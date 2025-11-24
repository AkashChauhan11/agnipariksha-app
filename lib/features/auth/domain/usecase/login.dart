import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class LoginUsecase extends UsecaseWithParams<Map<String, dynamic>, LoginParams> {
  //constructor injection of the auth repository
  const LoginUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<Map<String, dynamic>> call(LoginParams params) async => 
      _repository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  //constructor
  const LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}


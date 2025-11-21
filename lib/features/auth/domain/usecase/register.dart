import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';

class RegisterUsecase extends UsecaseWithParams<Map<String, dynamic>, RegisterParams> {

  //constructor injection of the auth repository
  const RegisterUsecase(this._repository);


  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<Map<String, dynamic>> call(RegisterParams params) async => _repository.register(firstName: params.firstName, lastName: params.lastName, email: params.email, password: params.password, phone: params.phone);
}


class RegisterParams  extends Equatable{
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phone;

  //constructor
  const RegisterParams({required this.firstName, required this.lastName, required this.email, required this.password, this.phone,});
  @override
  List<Object?> get props => [firstName, lastName, email, password, phone];
}
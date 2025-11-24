import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/entities/user.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';

class GetCurrentUserUsecase extends UsecaseWithoutParams<User> {
  //constructor injection of the auth repository
  const GetCurrentUserUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultFuture<User> call() async => _repository.getCurrentUser();
}


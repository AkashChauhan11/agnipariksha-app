import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';

class LogoutUsecase extends UsecaseWithoutParams<void> {
  //constructor injection of the auth repository
  const LogoutUsecase(this._repository);

  //repository instance
  final AuthRepository _repository;
  
  @override
  ResultVoid call() async => _repository.logout();
}


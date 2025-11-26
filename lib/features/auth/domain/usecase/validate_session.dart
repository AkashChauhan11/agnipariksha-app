import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/auth/domain/repositories/auth_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import '../entities/user.dart';

class ValidateSessionUsecase extends UsecaseWithoutParams<User> {
  const ValidateSessionUsecase(this._repository);

  final AuthRepository _repository;
  
  @override
  ResultFuture<User> call() async => _repository.getProfile();
}


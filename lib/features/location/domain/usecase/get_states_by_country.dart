import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/location/domain/repositories/location_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';
import '../entities/state.dart';

class GetStatesByCountryUsecase extends UsecaseWithParams<List<State>, GetStatesByCountryParams> {
  const GetStatesByCountryUsecase(this._repository);

  final LocationRepository _repository;
  
  @override
  ResultFuture<List<State>> call(GetStatesByCountryParams params) async => 
      _repository.getStatesByCountry(
        countryId: params.countryId,
        isActive: params.isActive,
      );
}

class GetStatesByCountryParams extends Equatable {
  final String countryId;
  final bool? isActive;

  const GetStatesByCountryParams({
    required this.countryId,
    this.isActive,
  });

  @override
  List<Object?> get props => [countryId, isActive];
}


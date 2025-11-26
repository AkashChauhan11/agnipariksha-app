import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/location/domain/repositories/location_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';
import '../entities/city.dart';

class GetCitiesByStateUsecase extends UsecaseWithParams<List<City>, GetCitiesByStateParams> {
  const GetCitiesByStateUsecase(this._repository);

  final LocationRepository _repository;
  
  @override
  ResultFuture<List<City>> call(GetCitiesByStateParams params) async => 
      _repository.getCitiesByState(
        stateId: params.stateId,
        isActive: params.isActive,
      );
}

class GetCitiesByStateParams extends Equatable {
  final String stateId;
  final bool? isActive;

  const GetCitiesByStateParams({
    required this.stateId,
    this.isActive,
  });

  @override
  List<Object?> get props => [stateId, isActive];
}


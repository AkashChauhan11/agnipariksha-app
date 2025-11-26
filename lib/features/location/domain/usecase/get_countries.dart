import 'package:agni_pariksha/core/usecase/usecase.dart';
import 'package:agni_pariksha/features/location/domain/repositories/location_repository.dart';
import 'package:agni_pariksha/utils/typedef.dart';
import 'package:equatable/equatable.dart';
import '../entities/country.dart';

class GetCountriesUsecase extends UsecaseWithParams<List<Country>, GetCountriesParams> {
  const GetCountriesUsecase(this._repository);

  final LocationRepository _repository;
  
  @override
  ResultFuture<List<Country>> call(GetCountriesParams params) async => 
      _repository.getCountries(isActive: params.isActive);
}

class GetCountriesParams extends Equatable {
  final bool? isActive;

  const GetCountriesParams({this.isActive});

  @override
  List<Object?> get props => [isActive];
}


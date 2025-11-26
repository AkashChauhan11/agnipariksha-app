import 'package:agni_pariksha/utils/typedef.dart';
import '../entities/state.dart';
import '../entities/city.dart';
import '../entities/country.dart';

abstract class LocationRepository {
  ResultFuture<List<Country>> getCountries({bool? isActive});
  
  ResultFuture<List<State>> getStatesByCountry({
    required String countryId,
    bool? isActive,
  });
  
  ResultFuture<List<City>> getCitiesByState({
    required String stateId,
    bool? isActive,
  });
}


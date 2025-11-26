import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_states_by_country.dart';
import '../../domain/usecase/get_cities_by_state.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetStatesByCountryUsecase getStatesByCountryUsecase;
  final GetCitiesByStateUsecase getCitiesByStateUsecase;

  // India country ID from database
  static const String indiaCountryId = 'ab05f70e-c94f-11f0-9ebc-a059509720e2';

  LocationCubit({
    required this.getStatesByCountryUsecase,
    required this.getCitiesByStateUsecase,
  }) : super(LocationInitial());

  Future<void> initializeIndia() async {
    loadStatesByCountry(indiaCountryId);
  }

  Future<void> loadStatesByCountry(String countryId) async {
    emit(LocationLoading());

    final result = await getStatesByCountryUsecase(
      GetStatesByCountryParams(countryId: countryId, isActive: true),
    );

    result.fold(
      (failure) => emit(LocationError(message: failure.message)),
      (states) => emit(StatesLoaded(states: states)),
    );
  }

  Future<void> loadCitiesByState(String stateId) async {
    emit(LocationLoading());

    final result = await getCitiesByStateUsecase(
      GetCitiesByStateParams(stateId: stateId, isActive: true),
    );

    result.fold(
      (failure) => emit(LocationError(message: failure.message)),
      (cities) => emit(CitiesLoaded(cities: cities)),
    );
  }

}


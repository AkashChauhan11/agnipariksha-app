import 'package:equatable/equatable.dart';
import '../../domain/entities/state.dart';
import '../../domain/entities/city.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class StatesLoaded extends LocationState {
  final List<State> states;

  const StatesLoaded({required this.states});

  @override
  List<Object?> get props => [states];
}

class CitiesLoaded extends LocationState {
  final List<City> cities;

  const CitiesLoaded({required this.cities});

  @override
  List<Object?> get props => [cities];
}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});

  @override
  List<Object?> get props => [message];
}


import 'package:equatable/equatable.dart';
import '../../domain/entities/state.dart';
import '../../domain/entities/city.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {
  final List<State>? states; // Preserve states during loading

  const LocationLoading({this.states});

  @override
  List<Object?> get props => [states];
}

class StatesLoaded extends LocationState {
  final List<State> states;

  const StatesLoaded({required this.states});

  @override
  List<Object?> get props => [states];
}

class CitiesLoaded extends LocationState {
  final List<State> states; // Preserve states when cities are loaded
  final List<City> cities;

  const CitiesLoaded({required this.states, required this.cities});

  @override
  List<Object?> get props => [states, cities];
}

class LocationError extends LocationState {
  final String message;
  final List<State>? states; // Preserve states on error

  const LocationError({required this.message, this.states});

  @override
  List<Object?> get props => [message, states];
}

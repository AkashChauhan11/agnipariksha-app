import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String id;
  final String name;
  final String stateId;
  final bool isActive;

  const City({
    required this.id,
    required this.name,
    required this.stateId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, stateId, isActive];
}


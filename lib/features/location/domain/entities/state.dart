import 'package:equatable/equatable.dart';

class State extends Equatable {
  final String id;
  final String name;
  final String? isoCode;
  final String countryId;
  final bool isActive;

  const State({
    required this.id,
    required this.name,
    this.isoCode,
    required this.countryId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, isoCode, countryId, isActive];
}


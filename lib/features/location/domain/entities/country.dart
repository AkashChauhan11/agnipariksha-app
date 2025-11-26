import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String id;
  final String name;
  final String? isoCode;
  final String? isoCode3;
  final String? phoneCode;
  final bool isActive;

  const Country({
    required this.id,
    required this.name,
    this.isoCode,
    this.isoCode3,
    this.phoneCode,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, isoCode, isoCode3, phoneCode, isActive];
}


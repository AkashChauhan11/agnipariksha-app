import '../../domain/entities/city.dart';

class CityModel extends City {
  const CityModel({
    required super.id,
    required super.name,
    required super.stateId,
    required super.isActive,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      stateId: json['stateId'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stateId': stateId,
      'isActive': isActive,
    };
  }
}


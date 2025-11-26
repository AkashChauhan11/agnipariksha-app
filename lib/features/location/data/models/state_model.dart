import '../../domain/entities/state.dart';

class StateModel extends State {
  const StateModel({
    required super.id,
    required super.name,
    super.isoCode,
    required super.countryId,
    required super.isActive,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isoCode: json['isoCode'] as String?,
      countryId: json['countryId'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isoCode': isoCode,
      'countryId': countryId,
      'isActive': isActive,
    };
  }
}


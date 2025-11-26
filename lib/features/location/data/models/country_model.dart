import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.id,
    required super.name,
    super.isoCode,
    super.isoCode3,
    super.phoneCode,
    required super.isActive,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isoCode: json['isoCode'] as String?,
      isoCode3: json['isoCode3'] as String?,
      phoneCode: json['phoneCode'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isoCode': isoCode,
      'isoCode3': isoCode3,
      'phoneCode': phoneCode,
      'isActive': isActive,
    };
  }
}


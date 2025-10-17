import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phone,
    required super.role,
    required super.isActive,
    required super.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String?,
      role: json['role'] as String,
      isActive: json['isActive'] as bool? ?? true,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'role': role,
      'isActive': isActive,
      'isVerified': isVerified,
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      role: role,
      isActive: isActive,
      isVerified: isVerified,
    );
  }
}


import 'dart:convert';

import 'package:agni_pariksha/utils/typedef.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.code,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phone,
    required super.role,
    required super.isActive,
    required super.isVerified,
  });


  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json) as DataMap);
  }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as String,
      code: map['userCode'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String?,
      role: map['role'] as String,
      isActive: map['isActive'] as bool? ?? true,
      isVerified: map['isVerified'] as bool? ?? false,
    );
  }


  UserModel copyWith({
    String? id,
    String? code,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    bool? isActive,
    bool? isVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      code: code ?? this.code,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'code': code,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'role': role,
      'isActive': isActive,
      'isVerified': isVerified,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  User toEntity() {
    return User(
      id: id,
      code: code,
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


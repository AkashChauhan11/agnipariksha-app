import '../../domain/entities/sub_tag.dart';

class SubTagModel extends SubTag {
  SubTagModel({
    required super.id,
    required super.name,
    required super.type,
    required super.tagId,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubTagModel.fromJson(Map<String, dynamic> json) {
    return SubTagModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      tagId: json['tagId'] as String,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'tagId': tagId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}


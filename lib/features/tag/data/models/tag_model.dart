import '../../domain/entities/tag.dart';

class TagModel extends Tag {
  const TagModel({
    required super.id,
    required super.name,
    required super.type,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: _tagTypeFromString(json['type'] as String),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': _tagTypeToString(type),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static TagType _tagTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'main':
        return TagType.main;
      case 'subject':
        return TagType.subject;
      default:
        throw ArgumentError('Unknown tag type: $type');
    }
  }

  static String _tagTypeToString(TagType type) {
    switch (type) {
      case TagType.main:
        return 'main';
      case TagType.subject:
        return 'subject';
    }
  }
}


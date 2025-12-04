import '../../domain/entities/tag.dart';

class TagModel extends Tag {
  const TagModel({
    required super.id,
    required super.name,
    required super.type,
    required super.isActive,
    super.image,
    required super.isHierarchical,
    super.hierarchicalType,
    required super.createdAt,
    required super.updatedAt,

  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: _tagTypeFromString(json['type'] as String),
      image: json['image'] != null ? json['image'] as String? : null,
      isHierarchical: json['isHierarchical'] as bool,
      hierarchicalType: json['hierarchicalType'] != null ? _tagHierarchicalTypeFromString(json['hierarchicalType'] as String) : null,
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
      'image': image,
      'isHierarchical': isHierarchical,
      'hierarchicalType': hierarchicalType,
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

  static TagHierarchicalType _tagHierarchicalTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'main':
        return TagHierarchicalType.main;
      case 'subject':
        return TagHierarchicalType.subject;
      case 'subtag':
        return TagHierarchicalType.subtag;
      default:
        throw ArgumentError('Unknown tag hierarchical type: $type');
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


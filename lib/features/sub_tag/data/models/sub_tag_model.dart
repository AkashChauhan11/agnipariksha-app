import '../../domain/entities/sub_tag.dart';

class SubTagModel extends SubTag {
  const SubTagModel({
    required super.id,
    required super.name,
    required super.tagId,
    required super.type,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubTagModel.fromJson(Map<String, dynamic> json) {
    return SubTagModel(
      id: json['id'] as String,
      name: json['name'] as String,
      tagId: json['tagId'] as String,
      type: _subTagTypeFromString(json['type'] as String),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagId': tagId,
      'type': _subTagTypeToString(type),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static SubTagType _subTagTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'class':
        return SubTagType.class_;
      case 'year':
        return SubTagType.year;
      case 'chapter':
        return SubTagType.chapter;
      case 'topic':
        return SubTagType.topic;
      default:
        throw ArgumentError('Unknown sub-tag type: $type');
    }
  }

  static String _subTagTypeToString(SubTagType type) {
    switch (type) {
      case SubTagType.class_:
        return 'class';
      case SubTagType.year:
        return 'year';
      case SubTagType.chapter:
        return 'chapter';
      case SubTagType.topic:
        return 'topic';
    }
  }
}

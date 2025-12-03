import 'package:equatable/equatable.dart';

enum SubTagType { class_, subcategory }

class SubTag extends Equatable {
  final String id;
  final String name;
  final String tagId;
  final SubTagType type;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubTag({
    required this.id,
    required this.name,
    required this.tagId,
    required this.type,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    tagId,
    type,
    isActive,
    createdAt,
    updatedAt,
  ];
}

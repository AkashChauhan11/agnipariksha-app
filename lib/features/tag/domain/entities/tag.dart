import 'package:equatable/equatable.dart';

enum TagType {
  main,
  subject,
}

enum TagHierarchicalType {
  main,
  subject,
  subtag
}

class Tag extends Equatable {
  final String id;
  final String name;
  final String? image;
  final TagType type;
  final bool isHierarchical;
  final TagHierarchicalType? hierarchicalType;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tag({
    required this.id,
    required this.name,
    this.image,
    required this.isHierarchical,
    this.hierarchicalType,
    required this.type,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, type, isActive, createdAt, updatedAt];
}


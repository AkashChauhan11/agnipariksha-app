import 'package:equatable/equatable.dart';

enum TagType {
  main,
  subject,
}

class Tag extends Equatable {
  final String id;
  final String name;
  final TagType type;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tag({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, type, isActive, createdAt, updatedAt];
}


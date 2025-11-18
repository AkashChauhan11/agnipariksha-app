class Tag {
  final String id;
  final String name;
  final String type; // 'main' or 'subject'
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tag({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}


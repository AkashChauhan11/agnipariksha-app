class SubTag {
  final String id;
  final String name;
  final String type; // 'sub-topic' or 'class'
  final String tagId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubTag({
    required this.id,
    required this.name,
    required this.type,
    required this.tagId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}


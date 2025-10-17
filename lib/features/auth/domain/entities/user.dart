class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String role;
  final bool isActive;
  final bool isVerified;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.role,
    required this.isActive,
    required this.isVerified,
  });

  String get fullName => '$firstName $lastName';
}


// household-management-system/lib/features/task_management/domain/entities/user.dart

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

enum UserRole {
  admin,
  user,
  guest,
}
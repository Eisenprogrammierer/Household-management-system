// household-management-system/lib/features/task_management/domain/repositories/user_repository.dart

Future<User> createUser(User user) async {
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(user.email)) {
    throw ArgumentError('Invalid email format');
  }
  if (user.name.trim().isEmpty) {
    throw ArgumentError('Name cannot be empty');
  }
  return user;
}

// household-management-system/lib/features/task_management/domain/repositories/user_repository.dart

abstract class UserRepository {
  Future<User> getUser(String id);
  Future<User> createUser(User user);
  Future<void> updateUserRole(String id, UserRole role);
  Future<List<TaskAssignment>> getUserAssignments(String userId);
  Future<void> assignTask(TaskAssignment assignment);
}

Future<User> createUser(User user) async {
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(user.email)) {
    throw ArgumentError('Invalid email format');
  }
  // Дополнительные проверки
}

// household-management-system/lib/features/task_management/domain/usecases/user_usecases.dart

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<User> call(String userId) async {
    return await repository.getUser(userId);
  }
}

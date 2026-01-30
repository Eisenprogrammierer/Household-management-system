// household-management-system/lib/features/task_management/data/repositories/user_local_data_source.dart

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String id;
  User user;
  UserRole role;
  String userId;
  TaskAssignment assignment;
}

abstract class UserLocalDataSource {
  Future<User> createUser(User user);
  Future<User?> getUser(String id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<User> userBox;

  UserLocalDataSourceImpl(this.userBox);

  @override
  Future<User> createUser(User user) async {
    await userBox.put(user.id, user);
    return user;
  }
}

// household-management-system/test/features/task_management/data/repositories/user_repository_impl_test.dart

void main() {
  final mockLocalDataSource = MockUserLocalDataSource();
  final repository = UserRepositoryImpl(mockLocalDataSource);

  group('UserRepositoryImpl', () {
    test('createUser returns user from local data source', () async {
      final user = User(id: '1', name: 'Test', email: 'test@example.com', role: UserRole.user);
      when(mockLocalDataSource.createUser(user)).thenAnswer((_) async => user);
      expect(await repository.createUser(user), user);
    });

    test('updateUserRole updates user role', () async {
      final user = User(id: '1', name: 'Test', email: 'test@example.com', role: UserRole.user);
      when(mockLocalDataSource.getUser('1')).thenAnswer((_) async => user);
      when(mockLocalDataSource.updateUser(any)).thenAnswer((_) async => {});
      await repository.updateUserRole('1', UserRole.admin);
      expect(user.role, UserRole.admin);
    });
  });
}

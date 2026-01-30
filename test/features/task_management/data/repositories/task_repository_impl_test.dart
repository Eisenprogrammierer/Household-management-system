// household-management-system/test/features/task_management/data/repositories/task_repository_impl_test.dart

void main() {
  final mockLocalDataSource = MockTaskLocalDataSource();
  final repository = TaskRepositoryImpl(mockLocalDataSource);

  group('TaskRepositoryImpl', () {
    test('createTask returns task from local data source', () async {
      final task = Task(id: '1', title: 'Test', description: '', dueDate: DateTime.now().add(Duration(days: 1)), priority: TaskPriority.low, category: TaskCategory.other);
      when(mockLocalDataSource.createTask(task)).thenAnswer((_) async => task);
      expect(await repository.createTask(task), task);
    });

    test('getTasksByCategory filters tasks by category', () async {
      final tasks = [
        Task(id: '1', title: 'Test', description: '', dueDate: DateTime.now(), priority: TaskPriority.low, category: TaskCategory.other),
        Task(id: '2', title: 'Test', description: '', dueDate: DateTime.now(), priority: TaskPriority.low, category: TaskCategory.cleaning),
      ];
      when(mockLocalDataSource.getTasks()).thenAnswer((_) async => tasks);
      expect((await repository.getTasksByCategory(TaskCategory.cleaning)).length, 1);
    });
  });
}

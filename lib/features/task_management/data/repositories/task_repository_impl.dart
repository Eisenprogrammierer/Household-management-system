// household-management-system/lib/features/task_management/data/repositories/task_repository_impl.dart

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Task> createTask(Task task) async {
    return await localDataSource.createTask(task);
  }

  @override
  Future<Task> getTask(String id) async {
    final task = await localDataSource.getTask(id);
    if (task == null) {
      throw Exception('Task not found');
    }
    return task;
  }

  @override
  Future<List<Task>> getTasksByCategory(TaskCategory category) async {
    final tasks = await localDataSource.getTasks();
    return tasks.where((t) => t.category == category).toList();
  }

  @override
  Future<List<Task>> getTasksByStatus(TaskStatus status) async {
    final tasks = await localDataSource.getTasks();
    return tasks.where((t) => t.status == status).toList();
  }

  @override
  Future<List<Task>> getUpcomingTasks(DateTime startDate, DateTime endDate) async {
    final tasks = await localDataSource.getTasks();
    return tasks.where((t) =>
      t.dueDate.isAfter(startDate) &&
      t.dueDate.isBefore(endDate)
    ).toList();
  }

  @override
  Future<List<Task>> getRecurringTasks() async {
    // TODO: Реализовать фильтрацию по признаку повторяемости
    return [];
  }

  @override
  Future<void> updateTaskStatus(String id, TaskStatus status) async {
    final task = await localDataSource.getTask(id);
    if (task == null) throw Exception('Task not found');
    task.status = status;
    await localDataSource.updateTask(task);
  }

  @override
  Future<List<Task>> getTasksByUser(String userId) async {
    // TODO: Реализовать связь с UserRepository
    return [];
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }

  @override
  Future<List<TaskAssignment>> getTaskAssignments(String taskId) async {
    // TODO: Реализовать работу с назначениями
    return [];
  }

  @override
  Future<void> assignTask(TaskAssignment assignment) async {
    // TODO: Сохранить назначение в хранилище
  }
}

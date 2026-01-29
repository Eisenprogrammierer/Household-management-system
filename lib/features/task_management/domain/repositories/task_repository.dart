// household-management-system/lib/features/task_management/domain/repositories/task_repository.dart

abstract class TaskRepository {
  Future<Task> getTask(String id);
  Future<List<Task>> getTasksByCategory(TaskCategory category);
  Future<List<Task>> getTasksByStatus(TaskStatus status);
  Future<List<Task>> getUpcomingTasks(DateTime startDate, DateTime endDate);
  Future<List<Task>> getRecurringTasks();
  Future<void> updateTaskStatus(String id, TaskStatus status);
  Future<List<Task>> getTasksByUser(String userId);
  Future<void> deleteTask(String id);
  Future<List<TaskAssignment>> getTaskAssignments(String taskId);
  Future<void> assignTask(TaskAssignment assignment);
  Future<List<Task>> getTasksByDateRange(DateTime start, DateTime end);
  Future<List<Task>> searchTasks(String query);
}

Future<Task> createTask(Task task) async {
  if (task.dueDate.isBefore(DateTime.now())) {
    throw ArgumentError('Due date cannot be in the past');
  }
  // Дополнительные проверки
  // Реализация сохранения
}
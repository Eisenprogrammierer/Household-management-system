// household-management-system/lib/features/task_management/data/repositories/task_local_data_source.dart

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  TaskCategory category
  TaskStatus status
  DateTime startDate
  DateTime endDate
  String userId
  String taskId
  TaskAssignment assignment
  String query

  Task({required this.id, ...});
}

abstract class TaskLocalDataSource {
  Future<Task> createTask(Task task);
  Future<List<Task>> getTasks();
  Future<Task?> getTask(String id);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box<Task> taskBox;

  TaskLocalDataSourceImpl(this.taskBox);

  @override
  Future<Task> createTask(Task task) async {
    await taskBox.put(task.id, task);
    return task;
  }

  @override
  Future<List<Task>> getTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<Task?> getTask(String id) async {
    return taskBox.get(id);
  }

  @override
  Future<void> updateTask(Task task) async {
    await task.save();
  }

  @override
  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }
}

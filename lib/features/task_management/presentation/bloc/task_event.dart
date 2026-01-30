// household-management-system/lib/features/task_management/presentation/bloc/task_event.dart

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class UpdateTaskStatus extends TaskEvent {
  final String taskId;
  final TaskStatus status;

  UpdateTaskStatus(this.taskId, this.status);
}

class CreateTask extends TaskEvent {
  final Task task;

  CreateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask(this.taskId);
}

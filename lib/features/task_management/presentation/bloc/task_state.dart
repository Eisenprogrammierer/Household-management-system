// household-management-system/lib/features/task_management/presentation/bloc/task_state.dart

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final List<Task> upcomingTasks;

  TaskLoaded(this.tasks, [this.upcomingTasks = const []]);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

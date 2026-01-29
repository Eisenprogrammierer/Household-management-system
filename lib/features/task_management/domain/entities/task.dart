// household-management-system/lib/features/task_management/domain/entities/task.dart

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final TaskCategory category;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.category,
    this.status = TaskStatus.pending,
  });
}

enum TaskPriority {
  low,
  medium,
  high,
}

enum TaskCategory {
  cleaning,
  bills,
  pets,
  maintenance,
  shopping,
  other,
}

enum TaskStatus {
  pending,
  completed,
  failed,
}

class TaskAssignment {
  final String id;
  final String taskId;
  final String userId;
  final DateTime assignedAt;
  final DateTime? completedAt;
  final TaskAssignmentStatus status;

  TaskAssignment({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.assignedAt,
    this.completedAt,
    this.status = TaskAssignmentStatus.pending,
  });
}

enum TaskAssignmentStatus {
  pending,
  accepted,
  completed,
  rejected,
}

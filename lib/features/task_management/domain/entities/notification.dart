// household-management-system/lib/features/task_management/domain/entities/notification.dart

class Notification {
  final String id;
  final String userId;
  final String taskId;
  final String message;
  final DateTime timestamp;
  NotificationStatus status;

  Notification({
    required this.id,
    required this.userId,
    required this.taskId,
    required this.message,
    required this.timestamp,
    this.status = NotificationStatus.sent,
  });
}

enum NotificationStatus {
  sent,
  read,
  archived,
}
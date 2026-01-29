// household-management-system/lib/features/task_management/domain/repositories/notification_repository.dart

abstract class NotificationRepository {
  Future<Notification> createNotification(Notification notification);
  Future<List<Notification>> getUserNotifications(String userId);
  Future<void> markAsRead(String id);
}

Future<Notification> createNotification(Notification notification) async {
  if (notification.timestamp.isAfter(DateTime.now())) {
    throw ArgumentError('Notification timestamp cannot be in the future');
  }
  // Дополнительные проверки
}

// household-management-system/lib/features/task_management/domain/usecases/notification_usecases.dart

class CreateNotification {
  final NotificationRepository repository;

  CreateNotification(this.repository);

  Future<Notification> call(Notification notification) async {
    return await repository.createNotification(notification);
  }
}

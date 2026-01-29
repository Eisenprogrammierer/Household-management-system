// household-management-system/lib/features/task_management/domain/usecases/validate_task.dart

class ValidateTask {
  Future<bool> call(Task task) async {
    if (task.dueDate.isBefore(DateTime.now())) return false;
    // Дополнительные проверки
    return true;
  }
}

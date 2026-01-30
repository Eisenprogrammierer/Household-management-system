// household-management-system/test/features/task_management/domain/usecases/validate_task_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:household_management_system/features/task_management/domain/entities/task.dart';
import 'package:household_management_system/features/task_management/domain/usecases/validate_task.dart';

void main() {
  test('ValidateTask returns false for past due date', () async {
    final task = Task(
      id: '1',
      title: 'Test',
      description: '',
      dueDate: DateTime.now().subtract(Duration(days: 1)),
      priority: TaskPriority.low,
      category: TaskCategory.other,
    );
    expect(await ValidateTask().call(task), isFalse);
  });

  test('ValidateTask returns true for future due date', () async {
    final task = Task(
      id: '1',
      title: 'Test',
      description: '',
      dueDate: DateTime.now().add(Duration(days: 1)),
      priority: TaskPriority.low,
      category: TaskCategory.other,
    );
    expect(await ValidateTask().call(task), isTrue);
  });
}

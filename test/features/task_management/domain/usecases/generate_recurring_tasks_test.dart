// household-management-system/test/features/task_management/domain/usecases/generate_recurring_tasks_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:household_management_system/features/task_management/domain/entities/task.dart';
import 'package:household_management_system/features/task_management/domain/entities/recurrence_rule.dart';
import 'package:household_management_system/features/task_management/domain/usecases/generate_recurring_tasks.dart';

void main() {
  test('GenerateRecurringTasks creates correct number of tasks', () {
    final baseTask = Task(
      id: '1',
      title: 'Test',
      description: '',
      dueDate: DateTime.now(),
      priority: TaskPriority.low,
      category: TaskCategory.other,
    );
    final rule = RecurrenceRule(
      id: '1',
      taskId: '1',
      frequency: RecurrenceFrequency.daily,
      interval: 1,
    );
    final tasks = TaskGenerator.generateRecurringTasks(
      baseTask,
      rule,
      DateTime.now(),
      DateTime.now().add(Duration(days: 2)),
    );
    expect(tasks.length, 3);
  });
}

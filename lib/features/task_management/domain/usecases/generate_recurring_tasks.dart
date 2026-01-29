// household-management-system/lib/features/task_management/domain/usecases/generate_recurring_tasks.dart

class TaskGenerator {
  static List<Task> generateRecurringTasks(
    Task baseTask,
    RecurrenceRule rule,
    DateTime startDate,
    DateTime endDate,
  ) {
    final tasks = <Task>[];
    var currentDate = startDate;

    while (currentDate.isBefore(endDate) || currentDate == endDate) {
      tasks.add(Task(
        id: '${baseTask.id}_${currentDate.millisecondsSinceEpoch}',
        title: baseTask.title,
        description: baseTask.description,
        dueDate: currentDate,
        priority: baseTask.priority,
        category: baseTask.category,
        status: TaskStatus.pending,
      ));

      currentDate = _getNextDate(currentDate, rule);
      if (rule.endDate != null && currentDate.isAfter(rule.endDate!)) {
        break;
      }
    }
    return tasks;
  }

static List<Task> generateRecurringTasks(Task baseTask, RecurrenceRule rule, DateTime startDate, DateTime endDate) {
  final tasks = <Task>[];
  var currentDate = startDate;

  while (currentDate.isBefore(endDate) || currentDate == endDate) {
    // Проверка byWeekDays
    if (rule.byWeekDays.isNotEmpty && !rule.byWeekDays.contains(currentDate.weekday)) {
      currentDate = _getNextDate(currentDate, rule);
      continue;
    }

    // Проверка byMonthDays
    if (rule.byMonthDays.isNotEmpty && !rule.byMonthDays.contains(currentDate.day)) {
      currentDate = _getNextDate(currentDate, rule);
      continue;
    }

    tasks.add(Task(
      id: '${baseTask.id}_${currentDate.millisecondsSinceEpoch}',
      title: baseTask.title,
      description: baseTask.description,
      dueDate: currentDate,
      priority: baseTask.priority,
      category: baseTask.category,
      status: TaskStatus.pending,
    ));

    currentDate = _getNextDate(currentDate, rule);
    if (rule.endDate != null && currentDate.isAfter(rule.endDate!)) break;
  }
  return tasks;
}

  static DateTime _getNextDate(DateTime current, RecurrenceRule rule) {
    switch (rule.frequency) {
    case RecurrenceFrequency.daily:
      return current.add(Duration(days: rule.interval));
    case RecurrenceFrequency.weekly:
      return current.add(Duration(days: rule.interval * 7));
    case RecurrenceFrequency.monthly:
      var nextMonth = current.month + rule.interval;
      var nextYear = current.year + (nextMonth - 1) ~/ 12;
      nextMonth = (nextMonth - 1) % 12 + 1;
      var day = current.day;
      if (nextMonth == 2 && day > 28) day = 28;
      return DateTime(nextYear, nextMonth, day);
      case RecurrenceFrequency.yearly:
        return DateTime(
          current.year + rule.interval,
          current.month,
          current.day,
        );
    }
  }
}

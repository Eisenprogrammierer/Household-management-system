// household-management-system/lib/features/task_management/domain/entities/schedule.dart

class Schedule {
  final String id;
  final String taskId;
  final ScheduleFrequency frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final String recurrenceRuleId;

  Schedule({
    required this.id,
    required this.taskId,
    required this.frequency,
    required this.startDate,
    required this.recurrenceRuleId,
    this.endDate,
  });
}

enum ScheduleFrequency {
  daily,
  weekly,
  monthly,
}
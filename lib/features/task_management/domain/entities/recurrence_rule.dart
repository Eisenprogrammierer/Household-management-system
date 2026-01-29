// household-management-system/lib/features/task_management/domain/entities/recurrence_rule.dart

class RecurrenceRule {
  final String id;
  final String taskId;
  final RecurrenceFrequency frequency;
  final int interval;
  final List<int> byWeekDays; // [1-7] для дней недели
  final List<int> byMonthDays; // [1-31] для дней месяца
  final DateTime? endDate;

  RecurrenceRule({
  required this.id,
  required this.taskId,
  required this.frequency,
  this.interval = 1,
  this.byWeekDays = const [],
  this.byMonthDays = const [],
  this.endDate,
     }) {
    if (byWeekDays.any((day) => day < 1 || day > 7)) throw ArgumentError('Invalid week day');
    if (byMonthDays.any((day) => day < 1 || day > 31)) throw ArgumentError('Invalid month day');
  }
}

enum RecurrenceFrequency {
  daily,
  weekly,
  monthly,
  yearly,
}

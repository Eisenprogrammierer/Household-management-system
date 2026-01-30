// household-management-system/lib/features/task_management/domain/repositories/schedule_repository.dart

abstract class ScheduleRepository {
  Future<Schedule> createSchedule(Schedule schedule);
  Future<List<Schedule>> getUserSchedules(String userId);
  Future<void> updateSchedule(Schedule schedule);
  Future<RecurrenceRule> createRecurrenceRule(RecurrenceRule rule);
  Future<List<RecurrenceRule>> getRecurrenceRules(String taskId);
  Future<void> deleteSchedule(String id);
  Future<void> deleteRecurrenceRule(String id);
  Future<RecurrenceRule> getRecurrenceRule(String ruleId);
  Future<List<RecurrenceRule>> getActiveRecurrenceRules();
}

Future<Schedule> createSchedule(Schedule schedule) async {
  if (schedule.startDate.isAfter(schedule.endDate ?? DateTime.now().add(const Duration(days: 365 * 10)))) {
    throw ArgumentError('Start date must be before end date');
  }
  if (schedule.recurrenceRuleId.isEmpty) {
    throw ArgumentError('Recurrence rule ID cannot be empty');
  }
  return schedule;
}

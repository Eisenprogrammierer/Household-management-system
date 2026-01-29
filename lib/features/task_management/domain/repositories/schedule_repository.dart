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
  if (schedule.startDate.isAfter(schedule.endDate ?? DateTime.now())) {
    throw ArgumentError('Start date must be before end date');
  }
  // Дополнительные проверки
}

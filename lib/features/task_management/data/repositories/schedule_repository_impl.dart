// household-management-system/lib/features/task_management/data/repositories/schedule_repository_impl.dart

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleLocalDataSource localDataSource;

  ScheduleRepositoryImpl(this.localDataSource);

  @override
  Future<Schedule> createSchedule(Schedule schedule) async {
    return await localDataSource.createSchedule(schedule);
  }

  @override
  Future<List<Schedule>> getUserSchedules(String userId) async {
    final schedules = await localDataSource.getSchedules();
    return schedules.where((s) => s.taskId.startsWith('user_$userId')).toList();
  }

  @override
  Future<void> updateSchedule(Schedule schedule) async {
    await localDataSource.updateSchedule(schedule);
  }

  @override
  Future<RecurrenceRule> createRecurrenceRule(RecurrenceRule rule) async {
    return await localDataSource.createRecurrenceRule(rule);
  }

  @override
  Future<List<RecurrenceRule>> getRecurrenceRules(String taskId) async {
    final rules = await localDataSource.getRecurrenceRules();
    return rules.where((r) => r.taskId == taskId).toList();
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await localDataSource.deleteSchedule(id);
  }

  @override
  Future<void> deleteRecurrenceRule(String id) async {
    await localDataSource.deleteRecurrenceRule(id);
  }

  @override
  Future<RecurrenceRule> getRecurrenceRule(String ruleId) async {
    final rule = await localDataSource.getRecurrenceRule(ruleId);
    if (rule == null) {
      throw Exception('Recurrence rule not found');
    }
    return rule;
  }

  @override
  Future<List<RecurrenceRule>> getActiveRecurrenceRules() async {
    final rules = await localDataSource.getRecurrenceRules();
    return rules.where((r) => r.endDate == null || r.endDate!.isAfter(DateTime.now())).toList();
  }
}

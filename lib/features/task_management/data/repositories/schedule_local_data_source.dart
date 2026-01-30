// household-management-system/lib/features/task_management/data/repositories/schedule_local_data_source.dart

@HiveType(typeId: 1)
class Schedule extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String taskId;
  @HiveField(2)
  final ScheduleFrequency frequency;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime? endDate;
  @HiveField(5)
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

@HiveType(typeId: 2)
class RecurrenceRule extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String taskId;
  @HiveField(2)
  final RecurrenceFrequency frequency;
  @HiveField(3)
  final int interval;
  @HiveField(4)
  final List<int> byWeekDays;
  @HiveField(5)
  final List<int> byMonthDays;
  @HiveField(6)
  final DateTime? endDate;

  RecurrenceRule({
    required this.id,
    required this.taskId,
    required this.frequency,
    this.interval = 1,
    this.byWeekDays = const [],
    this.byMonthDays = const [],
    this.endDate,
  });
}

abstract class ScheduleLocalDataSource {
  Future<Schedule> createSchedule(Schedule schedule);
  Future<List<Schedule>> getSchedules();
  Future<Schedule?> getSchedule(String id);
  Future<void> updateSchedule(Schedule schedule);
  Future<void> deleteSchedule(String id);
  Future<RecurrenceRule> createRecurrenceRule(RecurrenceRule rule);
  Future<List<RecurrenceRule>> getRecurrenceRules();
  Future<RecurrenceRule?> getRecurrenceRule(String id);
  Future<void> deleteRecurrenceRule(String id);
}

class ScheduleLocalDataSourceImpl implements ScheduleLocalDataSource {
  final Box<Schedule> scheduleBox;
  final Box<RecurrenceRule> recurrenceRuleBox;

  ScheduleLocalDataSourceImpl(this.scheduleBox, this.recurrenceRuleBox);

  @override
  Future<Schedule> createSchedule(Schedule schedule) async {
    await scheduleBox.put(schedule.id, schedule);
    return schedule;
  }

  @override
  Future<List<Schedule>> getSchedules() async {
    return scheduleBox.values.toList();
  }

  @override
  Future<Schedule?> getSchedule(String id) async {
    return scheduleBox.get(id);
  }

  @override
  Future<void> updateSchedule(Schedule schedule) async {
    await schedule.save();
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await scheduleBox.delete(id);
  }

  @override
  Future<RecurrenceRule> createRecurrenceRule(RecurrenceRule rule) async {
    await recurrenceRuleBox.put(rule.id, rule);
    return rule;
  }

  @override
  Future<List<RecurrenceRule>> getRecurrenceRules() async {
    return recurrenceRuleBox.values.toList();
  }

  @override
  Future<RecurrenceRule?> getRecurrenceRule(String id) async {
    return recurrenceRuleBox.get(id);
  }

  @override
  Future<void> deleteRecurrenceRule(String id) async {
    await recurrenceRuleBox.delete(id);
  }
}

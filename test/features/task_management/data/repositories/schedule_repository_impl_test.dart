// household-management-system/test/features/task_management/data/repositories/schedule_repository_impl_test.dart

void main() {
  final mockLocalDataSource = MockScheduleLocalDataSource();
  final repository = ScheduleRepositoryImpl(mockLocalDataSource);

  group('ScheduleRepositoryImpl', () {
    test('createSchedule returns schedule from local data source', () async {
      final schedule = Schedule(id: '1', taskId: '1', frequency: ScheduleFrequency.daily, startDate: DateTime.now(), recurrenceRuleId: '1');
      when(mockLocalDataSource.createSchedule(schedule)).thenAnswer((_) async => schedule);
      expect(await repository.createSchedule(schedule), schedule);
    });

    test('getActiveRecurrenceRules filters active rules', () async {
      final rules = [
        RecurrenceRule(id: '1', taskId: '1', frequency: RecurrenceFrequency.daily, endDate: DateTime.now().add(Duration(days: 1))),
        RecurrenceRule(id: '2', taskId: '2', frequency: RecurrenceFrequency.daily, endDate: DateTime.now().subtract(Duration(days: 1))),
      ];
      when(mockLocalDataSource.getRecurrenceRules()).thenAnswer((_) async => rules);
      expect((await repository.getActiveRecurrenceRules()).length, 1);
    });
  });
}

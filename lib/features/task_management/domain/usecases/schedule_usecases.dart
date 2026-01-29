// household-management-system/lib/features/task_management/domain/usecases/schedule_usecases.dart

class CreateSchedule {
  final ScheduleRepository repository;

  CreateSchedule(this.repository);

  Future<Schedule> call(Schedule schedule) async {
    return await repository.createSchedule(schedule);
  }
}

// household-management-system/lib/features/task_management/domain/usecases/task_usecases.dart

class GetUpcomingTasks {
  final TaskRepository taskRepository;
  final ScheduleRepository scheduleRepository;

  GetUpcomingTasks(this.taskRepository, this.scheduleRepository);

  Future<List<Task>> call(DateTime startDate, DateTime endDate) async {
    final regularTasks = await taskRepository.getUpcomingTasks(startDate, endDate);
    final recurringTasks = await taskRepository.getRecurringTasks();

    final generatedTasks = await Future.wait(
      recurringTasks.map((task) async {
        final rules = await scheduleRepository.getRecurrenceRules(task.id);
        return TaskGenerator.generateRecurringTasks(
          task,
          rules.first,
          startDate,
          endDate,
        );
      }),
    );

    return [...regularTasks, ...generatedTasks.expanded.toList()]
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }
}

// household-management-system/lib/features/task_management/presentation/bloc/task_bloc.dart

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  final ScheduleRepository scheduleRepository;

  TaskBloc(this.taskRepository, this.scheduleRepository) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<UpdateTaskStatus>(_onUpdateTaskStatus);
    on<CreateTask>(_onCreateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await taskRepository.getTasks();
      final upcomingTasks = await taskRepository.getUpcomingTasks(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 7))
      );
      emit(TaskLoaded(tasks, upcomingTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onUpdateTaskStatus(UpdateTaskStatus event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.updateTaskStatus(event.taskId, event.status);
      final tasks = await taskRepository.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onCreateTask(CreateTask event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.createTask(event.task);
      final tasks = await taskRepository.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await taskRepository.deleteTask(event.taskId);
      final tasks = await taskRepository.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}

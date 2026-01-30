// household-management-system/lib/features/task_management/presentation/pages/task_list_page.dart

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskError) {
          return Center(child: Text(state.message));
        }
        if (state is TaskLoaded) {
          return TaskList(
            tasks: state.tasks,
            onStatusChange: (id) => taskBloc.add(UpdateTaskStatus(id, TaskStatus.completed)),
            onDelete: (id) => taskBloc.add(DeleteTask(id)),
          );
        }
        return Container();
      },
    );
  }
}

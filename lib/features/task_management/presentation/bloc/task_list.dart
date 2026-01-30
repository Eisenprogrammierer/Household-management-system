// household-management-system/lib/features/task_management/presentation/bloc/task_list.dart

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onStatusChange;
  final Function(String) onDelete;

  const TaskList({
    Key? key,
    required this.tasks,
    required this.onStatusChange,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          task: tasks[index],
          onStatusChange: onStatusChange,
          onDelete: onDelete,
        );
      },
    );
  }
}

// household-management-system/lib/features/task_management/presentation/widgets/task_item.dart

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(String) onStatusChange;
  final Function(String) onDelete;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onStatusChange,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.dueDate.toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: task.status == TaskStatus.completed,
            onChanged: (value) => onStatusChange(task.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(task.id),
          ),
        ],
      ),
    );
  }
}

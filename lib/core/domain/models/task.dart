class Task {
  final String id;
  final String name;
  final String status; // 'pending' или 'completed'
  final DateTime createdAt;
  final DateTime? dueDate; // null для задач без срока

  Task({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'dueDate': dueDate?.toIso8601String(),
  };
}


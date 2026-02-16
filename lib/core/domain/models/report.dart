class Report extends BaseModel {
  final String content;
  final DateTime createdAt;

  Report({required String id, required this.content, required this.createdAt})
    : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json['id'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}


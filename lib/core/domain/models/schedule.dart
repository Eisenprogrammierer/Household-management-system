class Schedule extends BaseModel {
  final DateTime startTime;
  final DateTime endTime;
  final String description;

  Schedule({
    required String id,
    required this.startTime,
    required this.endTime,
    required this.description
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'description': description,
  };

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json['id'],
    startTime: DateTime.parse(json['startTime']),
    endTime: DateTime.parse(json['endTime']),
    description: json['description'],
  );
}

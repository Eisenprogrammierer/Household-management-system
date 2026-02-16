class Device extends BaseModel {
  final String name;
  final String type;

  Device({required String id, required this.name, required this.type})
    : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
  };

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json['id'],
    name: json['name'],
    type: json['type'],
  );
}

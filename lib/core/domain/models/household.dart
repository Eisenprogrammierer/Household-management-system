class Household extends BaseModel {
  final String name;
  final List<String> members;

  Household({required String id, required this.name, required this.members})
    : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'members': members,
  };

  factory Household.fromJson(Map<String, dynamic> json) => Household(
    id: json['id'],
    name: json['name'],
    members: (json['members'] as List).map((e) => e as String).toList(),
  );
}


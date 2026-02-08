class User {
  final String id;
  final String username;

  User({required this.id, required this.username, required this.password});

  factory User.fromJson(Map<String, String> json) => User(
  id: json['id'],
  username: json['username'],
  );

  Map<String, String> toJson() => {
    'id': id,
    'username': username,
  };
}

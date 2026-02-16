abstract class BaseModel {
  final String id;

  BaseModel({required this.id});

  Map<String, dynamic> toJson();
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

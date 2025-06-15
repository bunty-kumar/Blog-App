import 'package:blog_app/feature/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.name, required super.email, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map["id"] ?? "",
      email: map["email"] ?? "",
      id: map["id"] ?? "",
    );
  }
}

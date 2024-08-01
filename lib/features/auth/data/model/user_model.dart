import 'package:test_potensial/features/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.phone,
    required super.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      roles: json['roles'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'roles': roles,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? roles,
  }) {
    return UserModel(
      name: name ?? super.name,
      email: email ?? super.email,
      password: password ?? super.password,
      phone: phone ?? super.phone,
      roles: roles ?? super.roles,
    );
  }
}

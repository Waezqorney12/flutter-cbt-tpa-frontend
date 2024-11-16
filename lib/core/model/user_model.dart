import 'package:test_potensial/core/config/api_config.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:path/path.dart' as path;

String? extractFilename(String imagePath) {
  return path.basename(imagePath);
}

class UserModel extends UserEntities {
  const UserModel({
    super.image,
    super.email,
    super.firstName,
    super.lastName,
    super.password,
    super.phone,
    super.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: '${ApiConfig.baseUrl}/storage/${json['image']}',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone_number'] ?? '',
      roles: json['roles'] ?? '',
    );
  }

  factory UserModel.fromEntities(UserEntities userEntities) {
    return UserModel(
      image: userEntities.image,
      email: userEntities.email,
      firstName: userEntities.firstName,
      lastName: userEntities.lastName,
      password: userEntities.password,
      phone: userEntities.phone,
      roles: userEntities.roles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'phone_number': phone,
      'roles': roles,
    };
  }

  UserModel copyWith({
    String? image,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? phone,
    String? roles,
  }) {
    return UserModel(
      image: image ?? super.image,
      email: email ?? super.email,
      firstName: firstName ?? super.firstName,
      lastName: lastName ?? super.lastName,
      password: password ?? super.password,
      phone: phone ?? super.phone,
      roles: roles ?? super.roles,
    );
  }
}

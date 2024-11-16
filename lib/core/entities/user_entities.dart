import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String? image;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? phone;
  final String? roles;

  const UserEntities({
    this.image,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.phone,
    this.roles,
  });

  @override
  List<Object?> get props => [image, email, firstName, lastName, password, phone, roles];
}

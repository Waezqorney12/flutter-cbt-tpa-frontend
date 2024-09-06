import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? roles;

  const UserEntities({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.roles,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password, phone, roles];
}

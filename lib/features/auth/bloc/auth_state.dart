part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLogin extends AuthState {
  final UserEntities user;

  const AuthLogin(this.user);

  @override
  List<Object> get props => [user];
}
final class AuthRegister extends AuthState {
  final String message;

  const AuthRegister(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

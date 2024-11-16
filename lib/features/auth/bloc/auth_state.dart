part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLogin extends AuthState {
  final String data;

  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
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

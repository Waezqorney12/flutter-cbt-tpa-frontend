part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoggedIn extends UserState {
  final UserEntities user;

  const UserLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

final class UserLoggeoOut extends UserState {
  final bool isLoggeoOut;
  const UserLoggeoOut({this.isLoggeoOut = false});

  @override
  List<Object> get props => [isLoggeoOut];
}

final class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

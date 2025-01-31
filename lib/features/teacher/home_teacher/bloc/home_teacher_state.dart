part of 'home_teacher_bloc.dart';

sealed class HomeTeacherState extends Equatable {
  const HomeTeacherState();

  @override
  List<Object> get props => [];
}

final class HomeTeacherInitial extends HomeTeacherState {}

final class HomeTeacherLoading extends HomeTeacherState {}

final class HomeTeacherLoaded extends HomeTeacherState {
  final List<ClassEntities> classes;
  const HomeTeacherLoaded(this.classes);

  @override
  List<Object> get props => [classes];
}

final class HomeTeacherSuccess extends HomeTeacherState {
  final String message;
  const HomeTeacherSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class HomeTeacherError extends HomeTeacherState {
  final String message;
  const HomeTeacherError(this.message);
  @override
  List<Object> get props => [message];
}

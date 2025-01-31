part of 'home_teacher_bloc.dart';

sealed class HomeTeacherEvent extends Equatable {
  const HomeTeacherEvent();

  @override
  List<Object> get props => [];
}

class CreateClassEvent extends HomeTeacherEvent {
  final CreateClassParams classes;
  const CreateClassEvent({required this.classes});

  @override
  List<Object> get props => [classes];
}

class GetClassEvent extends HomeTeacherEvent {
  const GetClassEvent();

  @override
  List<Object> get props => [];
}

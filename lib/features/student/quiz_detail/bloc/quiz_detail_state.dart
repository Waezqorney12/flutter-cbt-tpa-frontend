part of 'quiz_detail_bloc.dart';

sealed class QuizDetailState extends Equatable {
  const QuizDetailState();

  @override
  List<Object> get props => [];
}

final class QuizDetailInitial extends QuizDetailState {}

final class QuizDetailLoading extends QuizDetailState {}

final class QuizDetailLoaded extends QuizDetailState {
  final QuizBaseResponseEntities responseQuizzes;
  const QuizDetailLoaded(this.responseQuizzes);

  @override
  List<Object> get props => [responseQuizzes];
}

final class UpdateQuizDetailLoaded extends QuizDetailState {
  final String message;
  const UpdateQuizDetailLoaded(this.message);

  @override
  List<Object> get props => [message];
}

final class QuizUserExit extends QuizDetailState {}

final class QuizDetailError extends QuizDetailState {
  final String message;
  const QuizDetailError(this.message);

  @override
  List<Object> get props => [message];
}

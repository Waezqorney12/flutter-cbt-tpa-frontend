part of 'quiz_detail_bloc.dart';

sealed class QuizDetailState extends Equatable {
  const QuizDetailState();

  @override
  List<Object> get props => [];
}

final class QuizDetailInitial extends QuizDetailState {}

final class QuizDetailLoading extends QuizDetailState {}

final class QuizDetailLoaded extends QuizDetailState {
  final List<QuizEntities> quizEntities;
  const QuizDetailLoaded(this.quizEntities);

  @override
  List<Object> get props => [quizEntities];
}

final class UpdateQuizDetailLoaded extends QuizDetailState {
  final String message;
  const UpdateQuizDetailLoaded(this.message);

  @override
  List<Object> get props => [message];
}

final class QuizDetailError extends QuizDetailState {
  final String message;
  const QuizDetailError(this.message);

  @override
  List<Object> get props => [message];
}

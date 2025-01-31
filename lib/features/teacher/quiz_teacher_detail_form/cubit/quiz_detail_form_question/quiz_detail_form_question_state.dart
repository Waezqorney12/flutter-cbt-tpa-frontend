part of 'quiz_detail_form_question_cubit.dart';

sealed class QuizDetailFormQuestionState extends Equatable {
  const QuizDetailFormQuestionState();

  @override
  List<Object> get props => [];
}

final class QuizDetailFormQuestionInitial extends QuizDetailFormQuestionState {}

final class QuizDetailFormQuestionLoading extends QuizDetailFormQuestionState {}

final class QuizDetailFormQuestionSuccess extends QuizDetailFormQuestionState {
  final String message;

  const QuizDetailFormQuestionSuccess(this.message);
}

final class QuizDetailFormQuestionError extends QuizDetailFormQuestionState {
  final String message;

  const QuizDetailFormQuestionError(this.message);
}

part of 'quiz_detail_form_cubit.dart';

sealed class QuizDetailFormState extends Equatable {
  const QuizDetailFormState();

  @override
  List<Object> get props => [];
}

final class QuizDetailFormInitial extends QuizDetailFormState {}

final class QuizDetailFormLoading extends QuizDetailFormState {}

final class QuizDetailFormLoaded extends QuizDetailFormState {
  final List<QuizQuestionEntities> question;

  const QuizDetailFormLoaded(this.question);
}

final class QuizDetailFormError extends QuizDetailFormState {
  final String message;
  const QuizDetailFormError(this.message);
}

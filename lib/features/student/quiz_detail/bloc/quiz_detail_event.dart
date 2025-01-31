part of 'quiz_detail_bloc.dart';

sealed class QuizDetailEvent extends Equatable {
  const QuizDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetQuizDetailEvent extends QuizDetailEvent {
  final GetDetailQuizParams params;
  const GetQuizDetailEvent(this.params);

  @override
  List<Object> get props => [params];
}

final class UserExitEvent extends QuizDetailEvent {
  final UserQuizParams params;

  const UserExitEvent(this.params);

  @override
  List<Object> get props => [params];
}

final class CalculateScoreEvent extends QuizDetailEvent {
  final UserQuizParams params;
  const CalculateScoreEvent({required this.params});

  @override
  List<Object> get props => [params];
}

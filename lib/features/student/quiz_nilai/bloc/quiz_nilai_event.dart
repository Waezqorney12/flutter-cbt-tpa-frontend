part of 'quiz_nilai_bloc.dart';

sealed class QuizNilaiEvent extends Equatable {
  const QuizNilaiEvent();

  @override
  List<Object> get props => [];
}

final class GetNilaiQuizEvent extends QuizNilaiEvent {
  final UserQuizParams params;
  const GetNilaiQuizEvent(this.params);

  @override
  List<Object> get props => [params];
}

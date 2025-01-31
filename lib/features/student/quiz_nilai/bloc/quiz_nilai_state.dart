part of 'quiz_nilai_bloc.dart';

sealed class QuizNilaiState extends Equatable {
  const QuizNilaiState();

  @override
  List<Object> get props => [];
}

final class QuizNilaiInitial extends QuizNilaiState {}

final class QuizNilaiLoading extends QuizNilaiState {}

final class QuizNilaiSuccess extends QuizNilaiState {
  final QuizNilaiEntities nilai;
  const QuizNilaiSuccess(this.nilai);

  @override
  List<Object> get props => [nilai];
}

final class QuizNilaiError extends QuizNilaiState {
  final String message;
  const QuizNilaiError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'quiz_detail_bloc.dart';

sealed class QuizDetailEvent extends Equatable {
  const QuizDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetQuizDetailEvent extends QuizDetailEvent {
  final String kategori;
  const GetQuizDetailEvent(this.kategori);

  @override
  List<Object> get props => [kategori];
}

final class QuizDetailReset extends QuizDetailEvent {}

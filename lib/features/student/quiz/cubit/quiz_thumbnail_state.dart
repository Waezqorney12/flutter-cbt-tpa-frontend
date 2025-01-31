part of 'quiz_thumbnail_cubit.dart';

sealed class QuizThumbnailState extends Equatable {
  const QuizThumbnailState();

  @override
  List<Object> get props => [];
}

final class QuizThumbnailInitial extends QuizThumbnailState {}

final class QuizThumbnailLoading extends QuizThumbnailState {}

final class QuizThumbnailLoaded extends QuizThumbnailState {
  final List<QuizThumbnailEntities> quizThumbnail;
  const QuizThumbnailLoaded(this.quizThumbnail);

  @override
  List<Object> get props => [quizThumbnail];
}

final class QuizThumbnailError extends QuizThumbnailState {
  final String message;
  const QuizThumbnailError(this.message);

  @override
  List<Object> get props => [message];
}

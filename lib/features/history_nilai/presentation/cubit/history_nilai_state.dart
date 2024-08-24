part of 'history_nilai_cubit.dart';

sealed class HistoryNilaiState extends Equatable {
  const HistoryNilaiState();

  @override
  List<Object> get props => [];
}

final class HistoryNilaiInitial extends HistoryNilaiState {}

final class HistoryNilaiLoading extends HistoryNilaiState {}

final class HistoryNilaiLoaded extends HistoryNilaiState {
  final List<HistoryNilaiEntities> entities;
  const HistoryNilaiLoaded(this.entities);

  @override
  List<Object> get props => [entities];
}

final class HistoryNilaiError extends HistoryNilaiState {
  final String message;
  const HistoryNilaiError(this.message);
  @override
  List<Object> get props => [message];
}

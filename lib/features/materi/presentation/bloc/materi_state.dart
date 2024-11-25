part of 'materi_bloc.dart';

sealed class MateriState extends Equatable {
  const MateriState();

  @override
  List<Object> get props => [];
}

final class MateriInitial extends MateriState {}

final class MateriLoading extends MateriState {}

final class MateriSuccess extends MateriState {
  final String success;
  const MateriSuccess(this.success);

  @override
  List<Object> get props => [success];
}

final class MateriLoaded extends MateriState {
  final List<MateriEntities> materi;
  const MateriLoaded(this.materi);

  @override
  List<Object> get props => [materi];
}

final class MateriError extends MateriState {
  final String message;
  const MateriError(this.message);

  @override
  List<Object> get props => [message];
}

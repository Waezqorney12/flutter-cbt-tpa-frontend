part of 'materi_bloc.dart';

sealed class MateriEvent extends Equatable {
  const MateriEvent();

  @override
  List<Object> get props => [];
}

final class GetAllMateriEvent extends MateriEvent {}
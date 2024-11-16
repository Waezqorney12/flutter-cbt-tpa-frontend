part of 'materi_bloc.dart';

sealed class MateriEvent extends Equatable {
  const MateriEvent();

  @override
  List<Object> get props => [];
}

final class GetAllMateriEvent extends MateriEvent {
  final String? kategori;
  const GetAllMateriEvent({this.kategori});

  @override
  List<Object> get props => [kategori ?? ''];
}

final class UpdateMateriEvent extends MateriEvent {
  final int id;
  const UpdateMateriEvent({required this.id});

  @override
  List<Object> get props => [id];
}

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/usecases/usescase_no_params.dart';
import 'package:test_potensial/features/materi/domain/usecases/materi_usecases.dart';

import '../../domain/entities/materi_entities.dart';

part 'materi_event.dart';
part 'materi_state.dart';

class MateriBloc extends Bloc<MateriEvent, MateriState> {
  final GetMateriUseCase _getMateri;
  final UpdateMateriUseCase _updateMateri;
  MateriBloc({
    required GetMateriUseCase getMateri,
    required UpdateMateriUseCase updateMateri,
  })  : _getMateri = getMateri,
        _updateMateri = updateMateri,
        super(MateriInitial()) {
    on<MateriEvent>((event, emit) => emit(MateriLoading()));
    on<GetAllMateriEvent>(
      (event, emit) async {
        final response = await _getMateri.call(event.kategori);
        response.fold(
          (failure) => emit(MateriError(failure.message)),
          (materi) => emit(MateriLoaded(materi)),
        );
      },
    );

    on<UpdateMateriEvent>(
      (event, emit) async {
        final response = await _updateMateri.call(UpdateParams(
          id: event.id,
          status: event.status,
        ));
        response.fold(
          (failure) => emit(MateriError(failure.message)),
          (materi) => emit(MateriSuccess(materi)),
        );
      },
    );
  }
}

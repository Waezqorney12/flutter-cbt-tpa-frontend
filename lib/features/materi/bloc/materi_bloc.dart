import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/usecases/usescase_no_params.dart';
import 'package:test_potensial/features/materi/domain/usecases/materi_usecases.dart';

import '../domain/entities/materi_entities.dart';

part 'materi_event.dart';
part 'materi_state.dart';

class MateriBloc extends Bloc<MateriEvent, MateriState> {
  final GetMateri _getMateri;
  final UpdateMateri _updateMateri;
  MateriBloc({
    required GetMateri getMateri,
    required UpdateMateri updateMateri,
  })  : _getMateri = getMateri,
        _updateMateri = updateMateri,
        super(MateriInitial()) {
    on<MateriEvent>((event, emit) => emit(MateriLoading()));
    on<GetAllMateriEvent>(
      (event, emit) async {
        final response = await _getMateri.call(NoParams());
        response.fold(
          (failure) => emit(MateriError(failure.message)),
          (materi) => emit(MateriLoaded(materi)),
        );
      },
    );

    on<UpdateMateriEvent>(
      (event, emit) async {
        final response = await _updateMateri.call(event.id);
        response.fold(
          (failure) => emit(MateriError(failure.message)),
          (materi) {
            emit(MateriSuccess(materi));
            add(GetAllMateriEvent());
          },
        );
      },
    );
  }
}

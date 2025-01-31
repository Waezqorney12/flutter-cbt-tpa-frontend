import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/usecases/usescase_no_params.dart';
import 'package:test_potensial/features/student/history_nilai/domain/usecase/history_nilai_usecase.dart';

import '../../domain/entities/history_nilai_entities.dart';

part 'history_nilai_state.dart';

class HistoryNilaiCubit extends Cubit<HistoryNilaiState> {
  final HistoryNilaiUsecase _usecase;
  HistoryNilaiCubit({
    required HistoryNilaiUsecase useCase,
  })  : _usecase = useCase,
        super(HistoryNilaiInitial());

  Future getHistoryNilai() async {
    emit(HistoryNilaiLoading());
    final response = await _usecase.call(NoParams());
    response.fold(
      (l) => emit(HistoryNilaiError(l.message)),
      (r) => emit(HistoryNilaiLoaded(r)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/entities/quiz_nilai_entities.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/usecase/quiz_nilai_usecase.dart';

part 'quiz_nilai_event.dart';
part 'quiz_nilai_state.dart';

class QuizNilaiBloc extends Bloc<QuizNilaiEvent, QuizNilaiState> {
  final GetNilaiJawabanUseCase _nilaiUsecase;
  QuizNilaiBloc({required GetNilaiJawabanUseCase nilaiUsecase})
      : _nilaiUsecase = nilaiUsecase,
        super(QuizNilaiInitial()) {
    on<QuizNilaiEvent>((event, emit) => emit(QuizNilaiLoading()));
    on<GetNilaiQuizEvent>(
      (event, emit) async {
        final response = await _nilaiUsecase.call(event.params);
        response.fold((failure) => emit(QuizNilaiError(failure.message)), (nilai) {
          emit(QuizNilaiSuccess(nilai));
        });
      },
    );
  }
}

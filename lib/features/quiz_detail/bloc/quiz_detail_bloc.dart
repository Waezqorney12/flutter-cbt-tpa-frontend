import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';

import '../domain/entities/quiz_entities.dart';

part 'quiz_detail_event.dart';
part 'quiz_detail_state.dart';

class QuizDetailBloc extends Bloc<QuizDetailEvent, QuizDetailState> {
  final GetQuizDetailUseCase _getQuizDetail;
  final CreateJawabanDetailUseCase _createJawaban;
  QuizDetailBloc({
    required GetQuizDetailUseCase getQuizDetail,
    required CreateJawabanDetailUseCase createJawaban,
  })  : _getQuizDetail = getQuizDetail,
        _createJawaban = createJawaban,
        super(QuizDetailInitial()) {
    on<QuizDetailEvent>((event, emit) => emit(QuizDetailLoading()));

    on<GetQuizDetailEvent>((event, emit) async {
      final result = await _getQuizDetail(event.kategori);
      result.fold((failure) => emit(QuizDetailError(failure.message)), (quizEntities) {
        emit(QuizDetailLoaded(quizEntities));
      });
    });

    on<CreateJawabanDetailEvent>((event, emit) async {
      final result = await _createJawaban(event.params);
      result.fold((failure) {
        emit(QuizDetailError(failure.message));
      }, (message) {
        emit(UpdateQuizDetailLoaded(message));
        emit(QuizDetailInitial());
      });
    });
  }
}
